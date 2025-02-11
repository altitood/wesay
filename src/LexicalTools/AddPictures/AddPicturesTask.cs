using SIL.IO;
using SIL.Reporting;
using SIL.Windows.Forms.ImageToolbox.ImageGallery;
using System.Windows.Forms;
using WeSay.LexicalModel;

namespace WeSay.LexicalTools.AddPictures
{
	public class AddPicturesTask : TaskBase
	{
		private readonly AddPicturesConfig _config;
		private Control _view;
		private ImageCollection _imageCollection;

		public AddPicturesTask(AddPicturesConfig config,
									LexEntryRepository lexEntryRepository,
								 TaskMemoryRepository taskMemoryRepository,
								IFileLocator fileLocator)
			: base(config, lexEntryRepository, taskMemoryRepository)
		{
			_config = config;
		}

		public override void Activate()
		{
			base.Activate();
			//ArtOReadingImageCollection
			//_imageCollection = ArtOReadingImageCollection.FromStandardLocations();
			_imageCollection = new ImageCollection("%ProgramData%\\SIL\\ImageCollections\\Art Of Reading");
			if (_imageCollection == null)
			{
				_imageCollection = new ImageCollection("/usr/share/SIL/ImageCollections/ArtOfReading");
			}
			if (_imageCollection == null)
			{
				throw new ConfigurationException("Could not locate image index.");
			}
		}




		public override Control Control
		{
			get
			{
				if (_view == null)
				{
					_view = new AddPicturesControl(this);
				}
				return _view;
			}
		}

		public ImageCollection ImageCollection
		{
			get
			{
				return _imageCollection;
			}
		}

		protected override int ComputeCount(bool returnResultEvenIfExpensive)
		{
			return 0;
		}

		protected override int ComputeReferenceCount()
		{
			return 0;
		}

		public override void FocusDesiredControl()
		{
			// This is the place to implement how the AddPictureTask selects its desired child control
			return;
		}
	}
}
