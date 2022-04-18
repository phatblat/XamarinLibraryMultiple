#
# Makefile
#
# Using `msbuild` instead of `dotnet <target>` because of errors
# error MSB4019: The imported project "/usr/local/share/dotnet/sdk/6.0.202/Xamarin/Android/Xamarin.Android.CSharp.targets" was not found. Confirm that the expression in the Import declaration "/usr/local/share/dotnet/sdk/6.0.202//Xamarin/Android/Xamarin.Android.CSharp.targets" is correct, and that the file exists on disk.
# error MSB3644: The reference assemblies for Xamarin.iOS,Version=v1.0 were not found.

.PHONY: info
info:
	dotnet --info
	msbuild --version
	msbuild -target:Info -verbosity:normal \
		XamarinLibraryMultiple.iOS/XamarinLibraryMultiple.iOS.csproj

.PHONY: clean
clean:
	msbuild -t:clean

# Installs dependencies through NuGet
.PHONY: restore
restore:
	dotnet restore

.PHONY: build
build: restore
	msbuild -restore:False -verbosity:normal
# -p:TargetFramework=Xamarin.iOS,Version=v1.0

.PHONY: dnbuild
dnbuild: restore
	dotnet build --no-restore -verbosity:detailed

.PHONY: pack
pack: build
	msbuild -t:pack \
		-p:Configuration=Release
