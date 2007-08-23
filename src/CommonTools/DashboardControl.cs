using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using WeSay.Language;
using WeSay.LexicalModel;
using WeSay.Project;
using WeSay.Data;
using WeSay.UI;

namespace WeSay.CommonTools
{
    public partial class DashboardControl : UserControl, ITask, IFinishCacheSetup
    {
        IRecordListManager _recordListManager;
        ICurrentWorkTask _currentWorkTaskProvider;
        IList<TaskIndicator> _taskIndicators;
        private bool _isActive;

        public DashboardControl(IRecordListManager recordListManager, ICurrentWorkTask currentWorkTaskProvider)
        {
            if (recordListManager == null)
            {
                throw new ArgumentNullException("recordListManager");
            }
            if (currentWorkTaskProvider == null)
            {
                throw new ArgumentNullException("currentWorkTaskProvider");
            }
            _taskIndicators = new List<TaskIndicator>();
            _recordListManager = recordListManager;
            _currentWorkTaskProvider = currentWorkTaskProvider;


            //InitializeComponent();
            ContextMenu = new ContextMenu();
            ContextMenu.MenuItems.Add("Configure this project...", new EventHandler(OnRunConfigureTool));

            //having trouble with the designer, so adding this here
            LocalizationHelper helper = new LocalizationHelper(null);
            helper.Parent = this;
            helper.EndInit();
        }

        
        private static void OnRunConfigureTool(object sender, EventArgs e)
        {
            string dir = Directory.GetParent(Application.ExecutablePath).FullName;
            ProcessStartInfo startInfo =
                new ProcessStartInfo(Path.Combine(dir, "WeSay Configuration Tool.exe"),
                                     string.Format("\"{0}\"", WeSayWordsProject.Project.ProjectDirectoryPath));
            try
            {
                Process.Start(startInfo);
            }
            catch
            {
                Palaso.Reporting.ErrorReport.ReportNonFatalMessage("Could not start "+startInfo.FileName);
            }

            Application.Exit();
        }

        private TaskIndicator TaskIndicatorFromTask(ITask task)
        {
            TaskIndicator taskIndicator = new TaskIndicator(task);
            taskIndicator.selected += new EventHandler(OnTaskIndicatorSelected);
            _taskIndicators.Add(taskIndicator);
            return taskIndicator;
        }

        void OnTaskIndicatorSelected(object sender, EventArgs e)
        {
            TaskIndicator taskIndicator = (TaskIndicator) sender;
            _currentWorkTaskProvider.ActiveTask = taskIndicator.Task;
        }
                
        private void AddIndicator(TaskIndicator indicator)
        {
            //indicator.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            indicator.Dock = DockStyle.Fill;
            
            Panel indentPanel = new Panel();
            indentPanel.DockPadding.Left = 70;
            indentPanel.DockPadding.Right = 20;
            //indentPanel.Location = new Point(70,0);
            //indicator.Left = 70;
            //indicator.Top = 0;
//            indentPanel.Left = 70;
            indentPanel.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
            indentPanel.Size = new Size(this._vbox.Width-170, indicator.Height);
            //indicator.Width = indentPanel.Width - 20;
            indentPanel.Controls.Add(indicator);
            this._vbox.AddControlToBottom(indentPanel);
        }

        private void InitializeProjectNameLabel()
        {
            this._projectNameLabel = new Label();
            this._projectNameLabel.AutoSize = true;
            this._projectNameLabel.Font = new Font("Microsoft Sans Serif", 20.25F, FontStyle.Bold, GraphicsUnit.Point, 0);
            this._projectNameLabel.Location = new Point(14, 13);
            this._projectNameLabel.Name = "_projectNameLabel";
            this._projectNameLabel.Size = new Size(194, 31);
            this._projectNameLabel.TabIndex = 0;
            this._projectNameLabel.Text = BasilProject.Project.Name;
            this._vbox.AddControlToBottom(this._projectNameLabel);
        }

        #region ITask
        public void Activate()
        {
            if (IsActive)
            {
                throw new InvalidOperationException("Activate should not be called when object is active.");
            }
            InitializeComponent();
            _vbox.SuspendLayout();
            this._vbox.Clear();
            Size originalSize = _vbox.Size; // this prevents us from growing wider than we should when we need a vertical scroll bar (and thus preventing the horizontal scroll bar)
            //_vbox.Size = new Size(10, 10);
            InitializeProjectNameLabel();
            IRecordList<LexEntry> entriesList = _recordListManager.GetListOfType<LexEntry>();
            ItemsToDoIndicator.MakeAllInstancesSameWidth(entriesList.Count);
            DictionaryStatusControl status = new DictionaryStatusControl(entriesList);
            this._vbox.AddControlToBottom(status);
            
            ITask currentWorkTask = _currentWorkTaskProvider.CurrentWorkTask;
            if (currentWorkTask != null)
            {
                TaskIndicator currentTaskIndicator = TaskIndicatorFromTask(currentWorkTask);
                CurrentTaskIndicatorControl control = new CurrentTaskIndicatorControl(currentTaskIndicator);
                control.Anchor = AnchorStyles.Left | AnchorStyles.Right | AnchorStyles.Top;
                _vbox.AddControlToBottom(control);
            }

            IList<ITask> taskList = ((WeSayWordsProject)BasilProject.Project).Tasks;
            foreach (ITask task in taskList)
            {
                if (task != this && task.IsPinned )
                {
                    AddIndicator(TaskIndicatorFromTask(task));
                }
            }

            int count = 0;
            foreach (ITask task in taskList)
            {
                if (task != this && !task.IsPinned)//&& (task != currentWorkTask))
                {
                    count++;
                }
            }

            if (count > 1 || currentWorkTask == null)
            {
                GroupHeader header = new GroupHeader();
                header.Name = StringCatalog.Get("~Tasks");
                AddGroupHeader(header);

                foreach (ITask task in taskList)
                {
                    if (task != this && !task.IsPinned) //&& (task != currentWorkTask))
                    {
                        AddIndicator(TaskIndicatorFromTask(task));
                    }
                }
            }

            _isActive = true;
            _vbox.VerticalScroll.Visible = true;
            _vbox.ResumeLayout(true);
            //_vbox.Size = originalSize;
        }


        private void AddGroupHeader(GroupHeader header)
        {
            header.Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right;
//            indentPanel.Size = new Size(indicator.Right, indicator.Height);
//            indentPanel.Controls.Add(indicator);
            this._vbox.AddControlToBottom(header);
        }

        public void Deactivate()
        {
            if(!IsActive)
            {
                throw new InvalidOperationException("Deactivate should only be called once after Activate.");
            }
            foreach (TaskIndicator taskIndicator in _taskIndicators)
            {
                taskIndicator.selected -= OnTaskIndicatorSelected;
            }
            for (int i = Controls.Count - 1; i >= 0; i--)
            {
                Controls[i].Dispose();
            }
            Controls.Clear();
            //this._vbox.Clear();
            _isActive = false;
        }

        public bool IsActive
        {
            get { return this._isActive; }
        }

        public string Label
        {
            get { return StringCatalog.Get("~Home", "The label for the 'dashboard'; the task which lets you see the status of other tasks and jump to them."); }
        }

        public Control Control
        {
            get { return this; }
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
                return StringCatalog.Get("~Switch tasks and see current status of tasks");
            }
        }

        #endregion

        #region IFinishCacheSetup Members

        public void FinishCacheSetup()
        {
            Activate();
            Deactivate();
        }

        #endregion
    }
}
