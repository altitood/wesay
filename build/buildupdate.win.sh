#!/bin/bash
# server=build.palaso.org
# build_type=bt455
# root_dir=..
# Auto-generated by https://github.com/chrisvire/BuildUpdate.
# Do not edit this file by hand!

cd "$(dirname "$0")"

# *** Functions ***
force=0
clean=0

while getopts fc opt; do
case $opt in
f) force=1 ;;
c) clean=1 ;;
esac
done

shift $((OPTIND - 1))

copy_auto() {
if [ "$clean" == "1" ]
then
echo cleaning $2
rm -f ""$2""
else
where_curl=$(type -P curl)
where_wget=$(type -P wget)
if [ "$where_curl" != "" ]
then
copy_curl $1 $2
elif [ "$where_wget" != "" ]
then
copy_wget $1 $2
else
echo "Missing curl or wget"
exit 1
fi
fi
}

copy_curl() {
echo "curl: $2 <= $1"
if [ -e "$2" ] && [ "$force" != "1" ]
then
curl -# -L -z $2 -o $2 $1
else
curl -# -L -o $2 $1
fi
}

copy_wget() {
echo "wget: $2 <= $1"
f=$(basename $2)
d=$(dirname $2)
cd $d
wget -q -L -N $1
cd -
}


# *** Results ***
# build: wesay1.6-win32-continuous (bt455)
# project: WeSay1.5
# URL: http://build.palaso.org/viewType.html?buildTypeId=bt455
# VCS: https://github.com/sillsdev/wesay.git [develop]
# dependencies:
# [0] build: chorus-win32-SILWritingSystems Continuous (bt453)
#     project: Chorus
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt453
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Chorus.exe"=>"lib/Release", "Chorus.pdb"=>"lib/Release", "ChorusMerge.exe"=>"lib/Release", "ChorusMerge.pdb"=>"lib/Release", "LibChorus.dll"=>"lib/Release", "LibChorus.pdb"=>"lib/Release", "LibChorus.TestUtilities.dll"=>"lib/Release", "LibChorus.TestUtilities.pdb"=>"lib/Release", "Autofac.dll"=>"lib/Release", "Mercurial.zip"=>"lib/Release", "debug/**"=>"lib/Debug", "MercurialExtensions/**"=>"MercurialExtensions", "ChorusMergeModule.msm"=>"lib"}
#     VCS: https://github.com/sillsdev/chorus.git [SILWritingSystems]
# [1] build: geckofx29-win32-continuous (bt399)
#     project: GeckoFx
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt399
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Geckofx-Core.dll"=>"lib/Release", "Geckofx-Core.dll.config"=>"lib/Release", "Geckofx-Winforms.dll"=>"lib/Release", "Geckofx-Winforms.pdb"=>"lib/Release"}
#     VCS: https://bitbucket.org/geckofx/geckofx-29.0 [default]
# [2] build: geckofx29-win32-continuous (bt399)
#     project: GeckoFx
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt399
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"Geckofx-Core.dll"=>"lib/Debug", "Geckofx-Core.dll.config"=>"lib/Debug", "Geckofx-Winforms.dll"=>"lib/Debug", "Geckofx-Winforms.pdb"=>"lib/Debug"}
#     VCS: https://bitbucket.org/geckofx/geckofx-29.0 [default]
# [3] build: XulRunner29-win32 (bt400)
#     project: GeckoFx
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt400
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"xulrunner-29.0.1.en-US.win32.zip!**"=>""}
# [4] build: L10NSharp continuous (bt196)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt196
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"L10NSharp.dll"=>"lib/Debug", "L10NSharp.pdb"=>"lib/Debug"}
#     VCS: https://bitbucket.org/sillsdev/l10nsharp []
# [5] build: L10NSharp continuous (bt196)
#     project: L10NSharp
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt196
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"L10NSharp.dll"=>"lib/Release", "L10NSharp.pdb"=>"lib/Release"}
#     VCS: https://bitbucket.org/sillsdev/l10nsharp []
# [6] build: icucil-win32-default Continuous (bt14)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt14
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"*"=>"lib/Release"}
#     VCS: https://github.com/sillsdev/icu-dotnet [master]
# [7] build: icucil-win32-default Continuous (bt14)
#     project: Libraries
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt14
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"*"=>"lib/Debug"}
#     VCS: https://github.com/sillsdev/icu-dotnet [master]
# [8] build: wesay-doc-default (bt184)
#     project: WeSay1.4
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt184
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"WeSay_Helps.chm"=>"External", "wesay.helpmap"=>"External"}
#     VCS: http://hg.palaso.org/wesay-doc []
# [9] build: wesay-localize-dev Update Pot and Po (bt52)
#     project: WeSay1.4
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt52
#     clean: false
#     revision: latest.lastFinished
#     paths: {"*.po"=>"common"}
#     VCS: http://hg.palaso.org/wesay-tx []
# [10] build: palaso-win32-SILWritingSystems Continuous (bt440)
#     project: libpalaso
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt440
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"SIL.Archiving.dll"=>"lib/Release", "SIL.Archiving.pdb"=>"lib/Release", "SIL.Core.dll"=>"lib/Release", "SIL.Core.pdb"=>"lib/Release", "SIL.Core.Tests.dll"=>"lib/Release", "SIL.Core.Tests.pdb"=>"lib/Release", "SIL.DictionaryServices.dll"=>"lib/Release", "SIL.DictionaryServices.pdb"=>"lib/Release", "SIL.Lexicon.dll"=>"lib/Release", "SIL.Lexicon.pdb"=>"lib/Release", "SIL.Lift.dll"=>"lib/Release", "SIL.Lift.pdb"=>"lib/Release", "SIL.Media.dll"=>"lib/Release", "SIL.Media.pdb"=>"lib/Release", "SIL.Scripture.dll"=>"lib/Release", "SIL.Scripture.pdb"=>"lib/Release", "SIL.TestUtilities.dll"=>"lib/Release", "SIL.TestUtilities.pdb"=>"lib/Release", "SIL.Windows.Forms.dll"=>"lib/Release", "SIL.Windows.Forms.pdb"=>"lib/Release", "SIL.Windows.Forms.GeckoBrowserAdapter.dll"=>"lib/Release", "SIL.Windows.Forms.GeckoBrowserAdapter.pdb"=>"lib/Release", "SIL.Windows.Forms.Keyboarding.dll"=>"lib/Release", "SIL.Windows.Forms.Keyboarding.pdb"=>"lib/Release", "SIL.Windows.Forms.Scripture.dll"=>"lib/Release", "SIL.Windows.Forms.Scripture.pdb"=>"lib/Release", "SIL.Windows.Forms.WritingSystems.dll"=>"lib/Release", "SIL.Windows.Forms.WritingSystems.pdb"=>"lib/Release", "SIL.WritingSystems.dll"=>"lib/Release", "SIL.WritingSystems.pdb"=>"lib/Release", "SIL.WritingSystems.Tests.dll"=>"lib/Release", "SIL.WritingSystems.Tests.pdb"=>"lib/Release", "Interop.WIA.dll"=>"lib/Release", "Spart.dll"=>"lib/Release", "taglib-sharp.dll"=>"lib/Release"}
#     VCS: https://github.com/sillsdev/libpalaso.git [SILWritingSystems]
# [11] build: palaso-win32-SILWritingSystems Continuous (bt440)
#     project: libpalaso
#     URL: http://build.palaso.org/viewType.html?buildTypeId=bt440
#     clean: false
#     revision: latest.lastSuccessful
#     paths: {"debug/SIL.Archiving.dll"=>"lib/Debug", "debug/SIL.Archiving.pdb"=>"lib/Debug", "debug/SIL.Core.dll"=>"lib/Debug", "debug/SIL.Core.pdb"=>"lib/Debug", "debug/SIL.Core.Tests.dll"=>"lib/Debug", "debug/SIL.Core.Tests.pdb"=>"lib/Debug", "debug/SIL.DictionaryServices.dll"=>"lib/Debug", "debug/SIL.DictionaryServices.pdb"=>"lib/Debug", "debug/SIL.Lexicon.dll"=>"lib/Debug", "debug/SIL.Lexicon.pdb"=>"lib/Debug", "debug/SIL.Lift.dll"=>"lib/Debug", "debug/SIL.Lift.pdb"=>"lib/Debug", "debug/SIL.Media.dll"=>"lib/Debug", "debug/SIL.Media.pdb"=>"lib/Debug", "debug/SIL.Scripture.dll"=>"lib/Debug", "debug/SIL.Scripture.pdb"=>"lib/Debug", "debug/SIL.TestUtilities.dll"=>"lib/Debug", "debug/SIL.TestUtilities.pdb"=>"lib/Debug", "debug/SIL.Windows.Forms.dll"=>"lib/Debug", "debug/SIL.Windows.Forms.pdb"=>"lib/Debug", "debug/SIL.Windows.Forms.GeckoBrowserAdapter.dll"=>"lib/Debug", "debug/SIL.Windows.Forms.GeckoBrowserAdapter.pdb"=>"lib/Debug", "debug/SIL.Windows.Forms.Keyboarding.dll"=>"lib/Debug", "debug/SIL.Windows.Forms.Keyboarding.pdb"=>"lib/Debug", "debug/SIL.Windows.Forms.Scripture.dll"=>"lib/Debug", "debug/SIL.Windows.Forms.Scripture.pdb"=>"lib/Debug", "debug/SIL.Windows.Forms.WritingSystems.dll"=>"lib/Debug", "debug/SIL.Windows.Forms.WritingSystems.pdb"=>"lib/Debug", "debug/SIL.WritingSystems.dll"=>"lib/Debug", "debug/SIL.WritingSystems.pdb"=>"lib/Debug", "debug/SIL.WritingSystems.Tests.dll"=>"lib/Debug", "debug/SIL.WritingSystems.Tests.pdb"=>"lib/Debug", "debug/Interop.WIA.dll"=>"lib/Debug", "debug/Spart.dll"=>"lib/Debug", "debug/taglib-sharp.dll"=>"lib/Debug"}
#     VCS: https://github.com/sillsdev/libpalaso.git [SILWritingSystems]

# make sure output directories exist
mkdir -p ../
mkdir -p ../Downloads
mkdir -p ../External
mkdir -p ../MercurialExtensions
mkdir -p ../MercurialExtensions/fixutf8
mkdir -p ../common
mkdir -p ../lib
mkdir -p ../lib/Debug
mkdir -p ../lib/Release

# download artifact dependencies
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/Chorus.exe ../lib/Release/Chorus.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/Chorus.pdb ../lib/Release/Chorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/ChorusMerge.exe ../lib/Release/ChorusMerge.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/ChorusMerge.pdb ../lib/Release/ChorusMerge.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/LibChorus.dll ../lib/Release/LibChorus.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/LibChorus.pdb ../lib/Release/LibChorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/LibChorus.TestUtilities.dll ../lib/Release/LibChorus.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/LibChorus.TestUtilities.pdb ../lib/Release/LibChorus.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/Autofac.dll ../lib/Release/Autofac.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/Mercurial.zip ../lib/Release/Mercurial.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/Autofac.dll ../lib/Debug/Autofac.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/Chorus.exe ../lib/Debug/Chorus.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/Chorus.pdb ../lib/Debug/Chorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/ChorusHub.exe ../lib/Debug/ChorusHub.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/ChorusHub.pdb ../lib/Debug/ChorusHub.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/ChorusMerge.exe ../lib/Debug/ChorusMerge.exe
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/ChorusMerge.pdb ../lib/Debug/ChorusMerge.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/LibChorus.TestUtilities.dll ../lib/Debug/LibChorus.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/LibChorus.TestUtilities.pdb ../lib/Debug/LibChorus.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/LibChorus.dll ../lib/Debug/LibChorus.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/debug/LibChorus.pdb ../lib/Debug/LibChorus.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/.guidsForInstaller.xml ../MercurialExtensions/.guidsForInstaller.xml
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/Dummy.txt ../MercurialExtensions/Dummy.txt
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/.gitignore ../MercurialExtensions/fixutf8/.gitignore
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/.guidsForInstaller.xml ../MercurialExtensions/fixutf8/.guidsForInstaller.xml
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/.hg_archival.txt ../MercurialExtensions/fixutf8/.hg_archival.txt
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/.hgignore ../MercurialExtensions/fixutf8/.hgignore
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/README. ../MercurialExtensions/fixutf8/README.
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/buildcpmap.py ../MercurialExtensions/fixutf8/buildcpmap.py
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/cpmap.pyc ../MercurialExtensions/fixutf8/cpmap.pyc
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/fixutf8.py ../MercurialExtensions/fixutf8/fixutf8.py
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/fixutf8.pyc ../MercurialExtensions/fixutf8/fixutf8.pyc
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/fixutf8.pyo ../MercurialExtensions/fixutf8/fixutf8.pyo
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/osutil.py ../MercurialExtensions/fixutf8/osutil.py
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/osutil.pyc ../MercurialExtensions/fixutf8/osutil.pyc
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/osutil.pyo ../MercurialExtensions/fixutf8/osutil.pyo
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/win32helper.py ../MercurialExtensions/fixutf8/win32helper.py
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/win32helper.pyc ../MercurialExtensions/fixutf8/win32helper.pyc
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/MercurialExtensions/fixutf8/win32helper.pyo ../MercurialExtensions/fixutf8/win32helper.pyo
copy_auto http://build.palaso.org/guestAuth/repository/download/bt453/latest.lastSuccessful/ChorusMergeModule.msm ../lib/ChorusMergeModule.msm
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Core.dll ../lib/Release/Geckofx-Core.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Core.dll.config ../lib/Release/Geckofx-Core.dll.config
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Winforms.dll ../lib/Release/Geckofx-Winforms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Winforms.pdb ../lib/Release/Geckofx-Winforms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Core.dll ../lib/Debug/Geckofx-Core.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Core.dll.config ../lib/Debug/Geckofx-Core.dll.config
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Winforms.dll ../lib/Debug/Geckofx-Winforms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt399/latest.lastSuccessful/Geckofx-Winforms.pdb ../lib/Debug/Geckofx-Winforms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt400/latest.lastSuccessful/xulrunner-29.0.1.en-US.win32.zip ../Downloads/xulrunner-29.0.1.en-US.win32.zip
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.dll ../lib/Debug/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.pdb ../lib/Debug/L10NSharp.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.dll ../lib/Release/L10NSharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt196/latest.lastSuccessful/L10NSharp.pdb ../lib/Release/L10NSharp.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll ../lib/Release/icu.net.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll.config ../lib/Release/icu.net.dll.config
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icudt54.dll ../lib/Release/icudt54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuin54.dll ../lib/Release/icuin54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuuc54.dll ../lib/Release/icuuc54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll ../lib/Debug/icu.net.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icu.net.dll.config ../lib/Debug/icu.net.dll.config
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icudt54.dll ../lib/Debug/icudt54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuin54.dll ../lib/Debug/icuin54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt14/latest.lastSuccessful/icuuc54.dll ../lib/Debug/icuuc54.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt184/latest.lastSuccessful/WeSay_Helps.chm ../External/WeSay_Helps.chm
copy_auto http://build.palaso.org/guestAuth/repository/download/bt184/latest.lastSuccessful/wesay.helpmap ../External/wesay.helpmap
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.az.po ../common/wesay.az.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.da.po ../common/wesay.da.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.es.po ../common/wesay.es.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.fr.po ../common/wesay.fr.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.he.po ../common/wesay.he.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.hi.po ../common/wesay.hi.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.id.po ../common/wesay.id.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.is.po ../common/wesay.is.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.km.po ../common/wesay.km.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.lo.po ../common/wesay.lo.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.my.po ../common/wesay.my.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.nl.po ../common/wesay.nl.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.oc.po ../common/wesay.oc.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.pl.po ../common/wesay.pl.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.pt.po ../common/wesay.pt.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.ru.po ../common/wesay.ru.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.rw.po ../common/wesay.rw.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.sv.po ../common/wesay.sv.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.th.po ../common/wesay.th.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.tpi.po ../common/wesay.tpi.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.vi.po ../common/wesay.vi.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.zh_CN.po ../common/wesay.zh_CN.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt52/latest.lastFinished/wesay.zh_TW.po ../common/wesay.zh_TW.po
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Archiving.dll ../lib/Release/SIL.Archiving.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Archiving.pdb ../lib/Release/SIL.Archiving.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Core.dll ../lib/Release/SIL.Core.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Core.pdb ../lib/Release/SIL.Core.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Core.Tests.dll ../lib/Release/SIL.Core.Tests.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Core.Tests.pdb ../lib/Release/SIL.Core.Tests.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.DictionaryServices.dll ../lib/Release/SIL.DictionaryServices.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.DictionaryServices.pdb ../lib/Release/SIL.DictionaryServices.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Lexicon.dll ../lib/Release/SIL.Lexicon.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Lexicon.pdb ../lib/Release/SIL.Lexicon.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Lift.dll ../lib/Release/SIL.Lift.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Lift.pdb ../lib/Release/SIL.Lift.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Media.dll ../lib/Release/SIL.Media.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Media.pdb ../lib/Release/SIL.Media.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Scripture.dll ../lib/Release/SIL.Scripture.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Scripture.pdb ../lib/Release/SIL.Scripture.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.TestUtilities.dll ../lib/Release/SIL.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.TestUtilities.pdb ../lib/Release/SIL.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.dll ../lib/Release/SIL.Windows.Forms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.pdb ../lib/Release/SIL.Windows.Forms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.GeckoBrowserAdapter.dll ../lib/Release/SIL.Windows.Forms.GeckoBrowserAdapter.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.GeckoBrowserAdapter.pdb ../lib/Release/SIL.Windows.Forms.GeckoBrowserAdapter.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.Keyboarding.dll ../lib/Release/SIL.Windows.Forms.Keyboarding.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.Keyboarding.pdb ../lib/Release/SIL.Windows.Forms.Keyboarding.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.Scripture.dll ../lib/Release/SIL.Windows.Forms.Scripture.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.Scripture.pdb ../lib/Release/SIL.Windows.Forms.Scripture.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.WritingSystems.dll ../lib/Release/SIL.Windows.Forms.WritingSystems.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.Windows.Forms.WritingSystems.pdb ../lib/Release/SIL.Windows.Forms.WritingSystems.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.WritingSystems.dll ../lib/Release/SIL.WritingSystems.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.WritingSystems.pdb ../lib/Release/SIL.WritingSystems.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.WritingSystems.Tests.dll ../lib/Release/SIL.WritingSystems.Tests.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/SIL.WritingSystems.Tests.pdb ../lib/Release/SIL.WritingSystems.Tests.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/Interop.WIA.dll ../lib/Release/Interop.WIA.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/Spart.dll ../lib/Release/Spart.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/taglib-sharp.dll ../lib/Release/taglib-sharp.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Archiving.dll ../lib/Debug/SIL.Archiving.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Archiving.pdb ../lib/Debug/SIL.Archiving.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Core.dll ../lib/Debug/SIL.Core.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Core.pdb ../lib/Debug/SIL.Core.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Core.Tests.dll ../lib/Debug/SIL.Core.Tests.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Core.Tests.pdb ../lib/Debug/SIL.Core.Tests.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.DictionaryServices.dll ../lib/Debug/SIL.DictionaryServices.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.DictionaryServices.pdb ../lib/Debug/SIL.DictionaryServices.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Lexicon.dll ../lib/Debug/SIL.Lexicon.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Lexicon.pdb ../lib/Debug/SIL.Lexicon.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Lift.dll ../lib/Debug/SIL.Lift.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Lift.pdb ../lib/Debug/SIL.Lift.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Media.dll ../lib/Debug/SIL.Media.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Media.pdb ../lib/Debug/SIL.Media.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Scripture.dll ../lib/Debug/SIL.Scripture.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Scripture.pdb ../lib/Debug/SIL.Scripture.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.TestUtilities.dll ../lib/Debug/SIL.TestUtilities.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.TestUtilities.pdb ../lib/Debug/SIL.TestUtilities.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.dll ../lib/Debug/SIL.Windows.Forms.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.pdb ../lib/Debug/SIL.Windows.Forms.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.GeckoBrowserAdapter.dll ../lib/Debug/SIL.Windows.Forms.GeckoBrowserAdapter.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.GeckoBrowserAdapter.pdb ../lib/Debug/SIL.Windows.Forms.GeckoBrowserAdapter.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.Keyboarding.dll ../lib/Debug/SIL.Windows.Forms.Keyboarding.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.Keyboarding.pdb ../lib/Debug/SIL.Windows.Forms.Keyboarding.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.Scripture.dll ../lib/Debug/SIL.Windows.Forms.Scripture.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.Scripture.pdb ../lib/Debug/SIL.Windows.Forms.Scripture.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.WritingSystems.dll ../lib/Debug/SIL.Windows.Forms.WritingSystems.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.Windows.Forms.WritingSystems.pdb ../lib/Debug/SIL.Windows.Forms.WritingSystems.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.WritingSystems.dll ../lib/Debug/SIL.WritingSystems.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.WritingSystems.pdb ../lib/Debug/SIL.WritingSystems.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.WritingSystems.Tests.dll ../lib/Debug/SIL.WritingSystems.Tests.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/SIL.WritingSystems.Tests.pdb ../lib/Debug/SIL.WritingSystems.Tests.pdb
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/Interop.WIA.dll ../lib/Debug/Interop.WIA.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/Spart.dll ../lib/Debug/Spart.dll
copy_auto http://build.palaso.org/guestAuth/repository/download/bt440/latest.lastSuccessful/debug/taglib-sharp.dll ../lib/Debug/taglib-sharp.dll
# extract downloaded zip files
unzip -uqo ../Downloads/xulrunner-29.0.1.en-US.win32.zip -d ../
# End of script
