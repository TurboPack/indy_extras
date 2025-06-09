#!/bin/bash
pushd ..
cp Source/*.pas ../git/TaurusTLS/Source/
cp Source/*.inc ../git/TaurusTLS/Source/
cp Source/*.dcr ../git/TaurusTLS/Source/
cp Source/*.lrs ../git/TaurusTLS/Source/

cp Source/*.pas ../git/indy_extras/TaurusTLS/Source/
cp Source/*.inc ../git/indy_extras/TaurusTLS/Source/
cp Source/*.dcr ../git/indy_extras/TaurusTLS/Source/
cp Source/*.lrs ../git/indy_extras/TaurusTLS/Source/
popd