#!/bin/bash
pushd ..
find Packages/ -name "*.dpk" -exec cp -p {} ../git/TaurusTLS/{} \;
find Packages/ -name "*.dproj" -exec cp -p {} ../git/TaurusTLS/{} \;
find Packages/ -name "*.pas" -exec cp -p {} ../git/TaurusTLS/{} \;
find Packages/ -name "*.lpk" -exec cp -p {} ../git/TaurusTLS/{} \;
find Packages/ -name "*.res" -exec cp -p {} ../git/TaurusTLS/{} \;

find Packages/ -name "*.dpk" -exec cp -p {} ../git/indy_extras/TaurusTLS/{} \;
find Packages/ -name "*.dproj" -exec cp -p {} ../git/indy_extras/TaurusTLS/{} \;
find Packages/ -name "*.pas" -exec cp -p {} ../git/indy_extras/TaurusTLS/{} \;
find Packages/ -name "*.lpk" -exec cp -p {} ../git/indy_extras/TaurusTLS/{} \;
find Packages/ -name "*.res" -exec cp -p {} ../git/indy_extras/TaurusTLS/{} \;

cp -p Source/TaurusTLS_Dsn_ResourceStrings.pas ../git/TaurusTLS/Source/
cp -p Source/TaurusTLS_Vers.inc ../git/TaurusTLS/Source/
cp -p tmsbuild.yaml ../git/TaurusTLS/
cp -p version.txt ../git/TaurusTLS/

cp -p Source/TaurusTLS_Dsn_ResourceStrings.pas ../git/TaurusTLS/Source/
cp -p Source/TaurusTLS_Vers.inc ../git/indy_extras/TaurusTLS//Source/
cp -p tmsbuild.yaml ../git/indy_extras/TaurusTLS/
cp -p version.txt ../git/indy_extras/TaurusTLS/

popd