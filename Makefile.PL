use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'ABSTRACT'	=> 'Tk::Wizard::Installer eg to download files',
    'NAME'		=> 'Tk::Wizard::Eg::Installer::Updater',
    'VERSION_FROM'	=> 'Updater.pl', # finds $VERSION
    'PREREQ_PM'		=> {
		'Tk::Wizard::Installer' => '0.03',
	}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (AUTHOR     => 'Lee Goddard <cpan -at- leegoddard -dot- com>') : ()),
);
