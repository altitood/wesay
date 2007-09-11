using System;
using System.Collections.Generic;
using WeSay.Data;
using WeSay.Language;
using WeSay.LexicalModel;
using WeSay.LexicalModel.Db4o_Specific;

namespace WeSay.LexicalTools
{
    public class LexEntrySortHelper: ISortHelper<string, LexEntry>
    {
        Db4oDataSource _db4oData; // for data
        WritingSystem _writingSystem;
        bool _isWritingSystemIdUsedByLexicalForm;
        
        public LexEntrySortHelper(Db4oDataSource db4oData, 
                                  WritingSystem writingSystem,
                                  bool isWritingSystemIdUsedByLexicalForm)
        {
            if(db4oData == null)
            {
                throw new ArgumentNullException("db4oData");
            }
            if (writingSystem == null)
            {
                throw new ArgumentNullException("writingSystem");
            }
            
            _db4oData = db4oData;
            _writingSystem = writingSystem;
            _isWritingSystemIdUsedByLexicalForm = isWritingSystemIdUsedByLexicalForm;
        }

        public LexEntrySortHelper(WritingSystem writingSystem,
                          bool isWritingSystemIdUsedByLexicalForm)
        {
            if (writingSystem == null)
            {
                throw new ArgumentNullException("writingSystemId");
            }

            _writingSystem = writingSystem;
            _isWritingSystemIdUsedByLexicalForm = isWritingSystemIdUsedByLexicalForm;
        }

        #region IDb4oSortHelper<string,LexEntry> Members

        public IComparer<string> KeyComparer
        {
            get
            {
                return _writingSystem;
            }
        }


        public List<KeyValuePair<string, long>> GetKeyIdPairs()
        {
            if (_db4oData != null)
            {
                if (_isWritingSystemIdUsedByLexicalForm)
                {
                    return KeyToEntryIdInitializer.GetLexicalFormToEntryIdPairs(_db4oData,
                                                                                _writingSystem.Id);
                }
                else
                {
                    return KeyToEntryIdInitializer.GetGlossToEntryIdPairs(_db4oData,
                                                                          _writingSystem.Id);
                }
            }
            throw new InvalidOperationException();
        }

        public IEnumerable<string> GetKeys(LexEntry item)
        {
            List<string> keys = new List<string>();
            if (_isWritingSystemIdUsedByLexicalForm)
            {
                keys.Add(item.LexicalForm.GetBestAlternative(_writingSystem.Id, "*"));
            }
            else
            {
                bool hasSense = false;
                foreach (LexSense sense in item.Senses)
                {
                    hasSense = true;

                    keys.AddRange(KeyToEntryIdInitializer.SplitGlossAtSemicolon(sense.Gloss, _writingSystem.Id));
                }
                if(!hasSense)
                {
                    keys.Add("*");
                }
            }
            return keys;
        }


        public string Name
        {
            get
            {
                return "LexEntry sorted by " + _writingSystem.Id;
            }
        }

        #endregion
    }
}
