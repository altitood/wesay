using System;
using System.Collections.Generic;
using Db4objects.Db4o;
using Palaso.Base32;
using Palaso.Text;
using WeSay.Data;
using WeSay.Foundation;
using WeSay.Language;

namespace WeSay.LexicalModel
{
    public class HeadwordSortedListHelper: ISortHelper<string, LexEntry>
    {
        Db4oDataSource _db4oData; // for data
        WritingSystem _writingSystem;
        private IHistoricalEntryCountProvider _historicalEntryCountProvider;

        public HeadwordSortedListHelper(Db4oRecordListManager recordListManager,
                                  WritingSystem writingSystem)
        {
            _db4oData = recordListManager.DataSource;
            _writingSystem = writingSystem;

            _historicalEntryCountProvider = HistoricalEntryCountProviderForDb4o.GetOrMakeFromDatabase(_db4oData);
        }


        #region IDb4oSortHelper<string,LexEntry> Members

        public IComparer<string> KeyComparer
        {
            get
            {
                return StringComparer.Ordinal;//in strict order; these are already sortkeys, not normal strings
            }
        }

        /// <summary>
        /// This is used to build the list from scratch
        /// </summary>
        /// <returns></returns>
        public List<KeyValuePair<string, long>> GetKeyIdPairs()
        {
            if (_db4oData != null)
            {
                List<KeyValuePair<string, long>> pairs = new List<KeyValuePair<string, long>>();

                IObjectSet set = _db4oData.Data.Get(typeof (LexEntry));

                //enhance: This will be slow and take a lot of ram, as it will bring each entry
                //into ram.  It is theoretically possible to just query on the lexemeform
                //and citation form for each entry, and compute the headword.
                foreach (LexEntry entry in set)
                {
                    foreach (string key in GetKeys(entry))
                    {
                        pairs.Add(new KeyValuePair<string, long>(key, _db4oData.Data.Ext().GetID(entry)));
                    }
                }
                return pairs;
            }
            throw new InvalidOperationException();
        }

        /// <summary>
        /// Get the keys (there's only one) for a single entry
        /// </summary>
        /// <param name="entry"></param>
        /// <returns></returns>
        public IEnumerable<string> GetKeys(LexEntry entry)
        {
            List<string> keys = new List<string>();
            string form = entry.GetHeadWordForm(_writingSystem.Id);
            byte[] keydata = _writingSystem.GetSortKey(form).KeyData;

            //turn that byte into something which, when sorted with ordinal sort order, will
            //give the correct ordering
            string key = Base32Convert.ToBase32HexString(keydata, Base32FormattingOptions.None);

            //this will change to incorporate homograph number, when the user can edit that (or we
            //import it)
            key += "_" + entry.DetermineBirthOrder(_historicalEntryCountProvider).ToString("000000"); 
            
            keys.Add(key);
            return keys;
        }



        public string Name
        {
            get
            {
                return "Headwords sorted by " + _writingSystem.Id;
            }
        }

        public override int GetHashCode()
        {
            return _writingSystem.GetHashCode();
        }

        #endregion
    }
}