using System;
using System.Collections.Generic;
using System.Diagnostics;
using Palaso.Text;
using WeSay.Data;
using WeSay.Foundation;
using WeSay.Foundation.Options;
using WeSay.LexicalModel;
using WeSay.Project;

namespace WeSay.LexicalTools
{
	public class MissingItemFilter: IFilter<LexEntry>
	{
		private readonly Field _field;

		public MissingItemFilter(Field field)
		{
			if (field == null)
			{
				throw new ArgumentNullException();
			}
			_field = field;
		}

		public MissingItemFilter(ViewTemplate viewTemplate, string fieldName)
		{
			if (viewTemplate == null)
			{
				throw new ArgumentNullException("viewTemplate");
			}
			if (fieldName == null)
			{
				throw new ArgumentNullException("fieldName");
			}
			Field field;
			if (!viewTemplate.TryGetField(fieldName, out field))
			{
				throw new ArgumentOutOfRangeException("viewTemplate",
													  "ViewTemplate is missing " + fieldName +
													  " field definition");
			}
			_field = field;
		}

		#region IFilter<LexEntry> Members

		/// <summary>
		/// Filters are kept in a list; this is the string by which a filter is accessed.
		/// </summary>
		public string Key
		{
			get
			{
				string key = "Missing " + _field.FieldName;
				List<string> writingSystemIds = new List<string>(_field.WritingSystemIds);
				writingSystemIds.Sort(StringComparer.InvariantCulture);
				foreach (string writingSystemId in writingSystemIds)
				{
					key += " [" + writingSystemId + "]";
				}
				key += " Filter";
				return key;
			}
		}

		public Predicate<LexEntry> FilteringPredicate
		{
			get { return IsMissingItem; }
		}

		public string FieldName
		{
			get { return _field.FieldName; }
		}

		private bool IsMissingDataInWritingSystem(object content)
		{
			switch (_field.DataTypeName)
			{
				case "Option":
					return ((OptionRef) content).IsEmpty;
				case "OptionCollection":
					return ((OptionRefCollection) content).IsEmpty;
				case "MultiText":
					return IsMissingWritingSystem((MultiText) content);
				case "RelationToOneEntry":
					LexRelationCollection collection = (LexRelationCollection) content;
					if (IsSkipped(collection.Parent, _field.FieldName))
					{
						return false;
					}
					else
					{
						foreach (LexRelation r in collection.Relations)
						{
							if (r.TargetId != null)
							{
								return false; // has one non-empty relation
							}
						}
						return true;
						//collection is empty or all its members don't really have targets
					}
				default:
					Debug.Fail("unknown DataTypeName");
					return false;
			}
		}

		private bool IsMissingItem(LexEntry entry)
		{
			if (entry == null)
			{
				return false;
			}

			switch (_field.ClassName)
			{
				case "LexEntry":
					return IsMissingLexEntryField(entry);
				case "LexSense": // fall through
				case "LexExampleSentence":
					foreach (LexSense sense in entry.Senses)
					{
						if (_field.ClassName == "LexSense")
						{
							if (IsMissingLexSenseField(sense))
							{
								return true;
							}
						}
						else
						{
							foreach (LexExampleSentence example in sense.ExampleSentences)
							{
								if (_field.ClassName == "LexExampleSentence")
								{
									if (IsMissingLexExampleSentenceField(example))
									{
										return true;
									}
								}
							}
							if (sense.ExampleSentences.Count == 0 &&
								(_field.FieldName == Field.FieldNames.ExampleSentence.ToString()))
							{
								//ghost field
								return true;
							}
						}
					}
					if (entry.Senses.Count == 0 &&
						(_field.FieldName == LexSense.WellKnownProperties.Definition))
					{
						//ghost field
						return true;
					}

					break;
				default:
					Debug.Fail("unknown ClassName");
					break;
			}
			return false;
		}

		private static bool IsSkipped(WeSayDataObject parent, string fieldName)
		{
			return parent.GetHasFlag("flag_skip_" + fieldName);
		}

		private bool IsMissingLexExampleSentenceField(LexExampleSentence example)
		{
			if (!_field.IsBuiltInViaCode)
			{
				return IsMissingCustomField(example);
			}
			else
			{
				if (_field.FieldName == Field.FieldNames.ExampleSentence.ToString())
				{
					return IsMissingWritingSystem(example.Sentence);
				}
				else if (_field.FieldName == Field.FieldNames.ExampleTranslation.ToString())
				{
					return IsMissingWritingSystem(example.Translation);
				}
				else
				{
					Debug.Fail("unknown FieldName");
					return false;
				}
			}
		}

		private bool IsMissingLexSenseField(WeSayDataObject sense)
		{
			if (!_field.IsBuiltInViaCode)
			{
				return IsMissingCustomField(sense);
			}
			else
			{
				//                if(this._field.FieldName == LexSense.WellKnownProperties.Gloss)
				//                {
				//                    return IsMissingWritingSystem(sense.Gloss);
				//                }
				//                else
				{
					Debug.Fail("unknown FieldName");
					return false;
				}
			}
		}

		private bool IsMissingLexEntryField(LexEntry entry)
		{
			if (!_field.IsBuiltInViaCode)
			{
				return IsMissingCustomField(entry);
			}
			else
			{
				if (_field.FieldName == Field.FieldNames.EntryLexicalForm.ToString())
				{
					if (IsMissingWritingSystem(entry.LexicalForm))
					{
						return true;
					}
				}
				else
				{
					Debug.Fail("unknown FieldName");
				}
			}
			return false;
		}

		private bool IsMissingCustomField(WeSayDataObject weSayData)
		{
			IParentable field = weSayData.GetProperty<IParentable>(_field.FieldName);
			if (field == null)
			{
				return !IsSkipped(weSayData, _field.FieldName);
			}
			return IsMissingDataInWritingSystem(field);
		}

		private bool IsMissingWritingSystem(MultiTextBase field)
		{
			foreach (string wsId in _field.WritingSystemIds)
			{
				if (field[wsId].Length == 0)
				{
					return true;
				}
			}
			return false;
		}

		#endregion
	}
}