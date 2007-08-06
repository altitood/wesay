using System;
using System.Windows.Forms;
using Mono.Addins;
using WeSay.AddinLib;
using WeSay.Language;
using WeSay.Project;

namespace WeSay.CommonTools
{
    public partial class ActionsControl : UserControl, ITask
    {
        private bool _isActive;
        private bool _wasLoaded=false;

        public ActionsControl()
        {
            InitializeComponent();
       }

        #region ITask
        public void Activate()
        {
            //get everything into the LIFT file
            if (WeSayWordsProject.Project.LiftUpdateService != null) // can be null when SampleDataProcessor runs
            {
                WeSayWordsProject.Project.LiftUpdateService.DoLiftUpdateNow(true);
            }
            if (!_wasLoaded)
            {
                _wasLoaded = true;
                LoadAddins();
            }
            _isActive = true;

        }

        private void LoadAddins()
        {
            _addinsList.Clear();
            if (!AddinManager.IsInitialized)
            {
//                AddinManager.Initialize(Application.UserAppDataPath);
//                AddinManager.Registry.Rebuild(null);
//                AddinManager.Shutdown();
                AddinManager.Initialize(Application.UserAppDataPath);
                AddinManager.Registry.Update(null);
                //these (at least AddinLoaded) does get called after initialize, when you
                //do a search for objects (e.g. GetExtensionObjects())
            }

            foreach (IWeSayAddin addin in AddinManager.GetExtensionObjects(typeof(IWeSayAddin)))
            {
                if (AddinSet.Singleton.DoShowInWeSay(addin.ID))
                {
                    AddAddin(addin);
                }
            }

//            AddAddin(new ComingSomedayAddin("Send My Work to Sangkran", "Send email containing all your WeSay work to your advisor.",
//                 WeSay.CommonTools.Properties.Resources.emailAction));
        }




        private void AddAddin(IWeSayAddin addin)
        {
            ActionItemControl control = new ActionItemControl(addin,false);
            _addinsList.AddControlToBottom(control);
            control.Launch += new EventHandler(OnLaunchAction);
        }

        private void OnLaunchAction(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;

            try
            {
                ((IWeSayAddin)sender).Launch(null, WeSay.Project.WeSayWordsProject.Project.GetProjectInfoForAddin());
            }
            catch (Exception error)
            {
                Reporting.ErrorReport.ReportNonFatalMessage(error.Message);
            }

            Cursor.Current = Cursors.Default;
        }

        public void Deactivate()
        {
            if(!IsActive)
            {
                throw new InvalidOperationException("Deactivate should only be called once after Activate.");
            }
           // this._vbox.Clear();
            _isActive = false;
        }

        public bool IsActive
        {
            get { return this._isActive; }
        }

        public string Label
        {
            get { return StringCatalog.Get("~Actions"); }
        }

        public Control Control
        {
            get { return this; }
        }

        public bool IsPinned
        {
            get
            {
                return true;
            }
        }

        public string Status
        {
            get
            {
                return string.Empty;
            }
        }
        public string ExactStatus
        {
            get
            {
                return Status;
            }
        }

        /// <summary>
        /// Not relevant for this task
        /// </summary>
        public int ReferenceCount
        {
            get
            {
                return -1;
            }
        }

        public string Description
        {
            get
            {
                return StringCatalog.Get("~Backup, create a progress report, etc.", "The description of the Actions task.");
            }
        }

        #endregion

    }
}