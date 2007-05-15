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
                //these (at least AddinLoaded) does get called after initialize, when you
                //do a search for objects (e.g. GetExtensionObjects())
            }

            foreach (IWeSayAddin addin in AddinManager.GetExtensionObjects(typeof(IWeSayAddin)))
            {
                AddAddin(addin);
            }
        }

        private void AddAddin(IWeSayAddin addin)
        {
            ActionItemControl control = new ActionItemControl(addin);
            _addinsList.AddControlToBottom(control);
            control.Launch += new EventHandler(OnLaunchAction);
        }

        private void OnLaunchAction(object sender, EventArgs e)
        {
            IWeSayAddin addin = sender as IWeSayAddin;
            WeSayWordsProject project = Project.WeSayWordsProject.Project;
            ProjectInfo projectInfo = new ProjectInfo(project.Name,
                                                    project.ProjectDirectoryPath,
                                                    project.PathToLiftFile,
                                                    WeSayWordsProject.GetFilesBelongingToProject(project.ProjectDirectoryPath));

            addin.Launch(null, projectInfo);          
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
            get { return StringCatalog.Get("Actions"); }
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

        public string Description
        {
            get
            {
                return StringCatalog.Get("Do other actions.");
            }
        }

        #endregion

    }
}
