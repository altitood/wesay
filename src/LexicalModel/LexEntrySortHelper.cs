using System;
using System.Collections.Generic;
using Palaso.UI.WindowsForms.i8n;
using WeSay.Data;
using WeSay.Foundation;
using WeSay.LexicalModel.Db4oSpecific;

namespace WeSay.LexicalModel
{
    public class LexEntrySortHelper: ISortHelper<LexEntry>
    {
        private readonly LexEntryRepository _lexEntryRepository; // for data
        private readonly WritingSystem _writingSystem;
        private readonly bool _isWritingSystemIdUsedByLexicalForm;

        public LexEntrySortHelper(LexEntryRepository lexEntryRepository,
                                  WritingSystem writingSystem,
                                  bool isWritingSystemIdUsedByLexicalForm)
        {
            if (lexEntryRepository == null)
            {
                throw new ArgumentNullException("lexEntryRepository");
            }
            if (writingSystem == null)
            {
                throw new ArgumentNullException("writingSystem");
            }

            _lexEntryRepository = lexEntryRepository;
            _writingSystem = writingSystem;
            _isWritingSystemIdUsedByLexicalForm = isWritingSystemIdUsedByLexicalForm;
        }

        #region IDb4oSortHelper<string,LexEntry> Members

        public IComparer<string> KeyComparer
        {
            get { return _writingSystem; }
        }

        public ResultSet<LexEntry> RetrieveItems()
        {
            if (_lexEntryRepository != null)
            {
                if (_isWritingSystemIdUsedByLexicalForm)
                {
                    return _lexEntryRepository.GetAllEntriesSortedByLexicalForm(_writingSystem);
                }
                else
                {
                    /* this broke when we moved gloss to just be a property (and definition is too)
              * But we only call it in the unlikely case that this particular index has disapeared,
              * so the fix can be really slow (this index is set up without respect to particular
              * tasks being active, unlike some other indices).
              * 
              * return KeyToEntryIdInitializer.GetGlossToEntryIdPairs(_db4oData,
              *                                                            _writingSystem.Id);
              */
                    List<RecordToken<LexEntry>> tokens = new List<RecordToken<LexEntry>>();
                    foreach (RepositoryId id in _lexEntryRepository.GetAllEntries())
                    {
                        LexEntry entry = _lexEntryRepository.GetItem(id);
                        int i = 0;
                        foreach (string s in GetDisplayStrings(entry))
                        {
                            tokens.Add(
                                    new RecordToken<LexEntry>(_lexEntryRepository, this, i, s, id));
                            ++i;
                        }
                    }
                    return new ResultSet<LexEntry>(_lexEntryRepository, tokens);
                }
            }
            throw new InvalidOperationException();
        }

        /// <summary>
        /// Starting from scratch, give me all the keys for every entry
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        public IEnumerable<string> GetDisplayStrings(LexEntry item)
        {
            //List<string> keys = new List<string>();
            //using a dictionary here just to prevent duplicate keys
            Dictionary<string, object> keys = new Dictionary<string, object>();

            if (_isWritingSystemIdUsedByLexicalForm)
            {
                string key = item.LexicalForm.GetBestAlternative(_writingSystem.Id, "*");
                if (key == "*")
                {
                    key = "(" +
                          StringCatalog.Get("~Empty",
                                            "This is what shows for a word in a list when the user hasn't yet typed anything in for the word.  Like if you click the 'New Word' button repeatedly.") +
                          ")";
                }
                keys.Add(key, null);
            }
            else
            {
                bool hasSense = false;
                //nb: the logic here relies on gloss being a requirement of having a sense.
                //If definition were allowed instead, we'd want to go to the second clause instead of outputtig
                //empty labels.
                foreach (LexSense sense in item.Senses)
                {
                    hasSense = true;

                    foreach (string s  in
                            KeyToEntryIdInitializer.SplitGlossAtSemicolon(sense.Gloss,
                                                                          _writingSystem.Id))
                    {
                        if (s != "*" && !keys.ContainsKey(s))
                        {
                            keys.Add(s, null);
                        }
                    }
                    foreach (string s in
                            KeyToEntryIdInitializer.SplitGlossAtSemicolon(sense.Definition,
                                                                          _writingSystem.Id))
                    {
                        if (s != "*" && !keys.ContainsKey(s))
                        {
                            keys.Add(s, null);
                        }
                    }
                }
                if (!hasSense)
                {
                    keys.Add(
                            "(" +
                            StringCatalog.Get("~No Gloss",
                                              "This is what shows if the user is listing words by the glossing language, but the word doesn't have a gloss.") +
                            ")",
                            null);
                }
            }
            return keys.Keys;
        }

        public string Name
        {
            get
            {
                string fieldName = _isWritingSystemIdUsedByLexicalForm ? "LexemeForm" : "Gloss";
                return "LexEntry sorted by " + _writingSystem.Id + " of " + fieldName;
            }
        }

        public override int GetHashCode()
        {
            return _writingSystem.GetHashCode();
        }

        #endregion
    }
}