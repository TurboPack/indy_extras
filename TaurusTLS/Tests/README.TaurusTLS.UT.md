"`markdown
# Unit Tests README

## Welcome!

This README is your go-to guide for developing, setting up, and running unit tests for TaurusTLS using the powerful DUnitX framework tailored for Delphi. We're excited to share that this project currently supports both Windows and Linux!

## Prerequisites

Before you dive in, make sure you have the following essentials ready:

- **Delphi**: Delphi 10 (Seattle) or newer
- **DUnitX framework**: https://github.com/VSoftTechnologies/DUnitX
- **FastMM5 unit**: https://github.com/pleriche/FastMM5
- **Fast**
- **Indy - Internet Direct library**: https://github.com/IndySockets/Indy
- **TaurusTLS library**: https://github.com/JPeterMugaas/TaurusTLS
- **OpenSSL binaries** for Windows or the OpenSSL package suitable for your Linux distribution

## Contributing to Unit Tests

We warmly invite you to get involved! To build a strong foundation, be sure to explore the **DUnitX** repository along with the **Embarcadero DocWiki**. These resources provide valuable insights and essential information on the fundamentals of DUnitX.

All unit tests needed are included in the project, `TaurusTLS.UT.dpr`. You are welcome to add new unit tests within this project or even create entirely new ones that suit your requirements.

For a smooth start, consider inheriting a test class from the `TOsslBaseFixture` found in the `TaurusTLS.UT.TestClasses` unit. This class will automatically load the `OpenSSL` library during `Fixture Setup` and unload it during `Fixture Teardown`. If there's ever a hiccup loading the OpenSSL library, your tests derived from `TOsslBaseFixture` will gracefully fail with the `EOsslBaseFixture` exception, keeping your testing experience clear and informative.

The `TOsslBaseFixture.SetupFixture` and `TOsslBaseFixture.TearDownFixture` are virtual methods. You can override them in your new Fixtures, but do not forget to call inherited methods to keep loading and unloading the OpenSSL library.

And remember, new fixtures must be registered explicitly in the DUnitX framework. Add the following code snippet to your unit initialization section:

```pascal
initialization
  TDUnitX.RegisterTestFixture(<your_fixture_class_name>);
end.
```

## Running Your Unit Tests

Running your unit tests is straightforward! You can execute them directly from the Delphi IDE, or if you prefer, run the compiled program separately. By default, all registered unit tests will run automatically, but you can customize your execution as needed. You can also use standard **DUnitX** command-line switches to filter out tests to run, test output details, etc.

### command-line switches
The `TaurusTLS.UT` extends **DUnitX** command-line switches set with new ones:
- **--opensslpath:value or -osp:value** - allows to specify path to **OpenSSL** library folder.
- **--fastmmdebugdll:value or -fmd:value** - Path to FastMM_FullDebugMode.dll or FastMM_FullDebugMode64.dll. This library is required to build detailed Memory Leak report. Please refer to the **FastMM5** documentation.
- **--fme:value or -fastmmlogenable:value** - enables or disables detailed Memory Leak report generation.
- **--fastmmlogname:value or -fml:value** - detailed Memory Leak report file name (default - stdout).

Let's get testing with enthusiasm and positivity!
```
