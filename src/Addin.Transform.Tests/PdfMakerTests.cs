using Addin.Transform.PdfDictionary;
using NUnit.Framework;
using SIL.WritingSystems;
using System.Diagnostics;
using System.IO;
using System.Threading;
using WeSay.AddinLib;
using WeSay.LexicalModel;
using WeSay.Project;
using WeSay.TestUtilities;

namespace Addin.Transform.Tests
{
	[TestFixture]
	public class PdfMakerTests
	{
		public PdfMaker _addin;
		private LexEntryRepository _lexEntryRepository;
		private string _filePath;
		private string _liftFilePath;
		private string _pdfPath;

		[OneTimeSetUp]
		public void OneTimeSetUp()
		{
			Sldr.Initialize(true);
		}

		[OneTimeTearDown]
		public void OneTimeTeardown()
		{
			Sldr.Cleanup();
		}

		[SetUp]
		public void Setup()
		{
			WeSayProjectTestHelper.InitializeForTests();
			_filePath = Path.GetTempFileName();
			_liftFilePath = Path.GetTempFileName();
			_lexEntryRepository = new LexEntryRepository(_filePath);

			_addin = new PdfMaker();
			_addin.LaunchAfterTransform = false;
		}

		[TearDown]
		public void TearDown()
		{
			if (_addin != null && File.Exists(_addin.PathToOutput))
			{
				File.Delete(_addin.PathToOutput);
			}
			if (_lexEntryRepository != null)
			{
				_lexEntryRepository.Dispose();
			}
			File.Delete(_filePath);
			File.Delete(_liftFilePath);
			WeSayProjectTestHelper.CleanupForTests();
		}

		[Test]
		[Category("SkipOnTeamCity")]
		public void CreatePDF()
		{
			LaunchAddin();
		}

		[Test]
		[Category("SkipOnTeamCity")]
		public void CreatePdfAndOpen()
		{
			LaunchAddin();
			Thread.Sleep(500);
			Process.Start(_pdfPath);
		}


		private void LaunchAddin()
		{
			ProjectInfo projectinfo = WeSayWordsProject.Project.GetProjectInfoForAddin();
			_pdfPath = Path.Combine(projectinfo.PathToExportDirectory,
											  projectinfo.Name + ".pdf");
			_addin.Launch(null, projectinfo);
			Assert.IsTrue(File.Exists(_pdfPath));
			bool succeeded = (new FileInfo(_pdfPath).Length > 0);
			Assert.IsTrue(succeeded);
		}
	}
}
