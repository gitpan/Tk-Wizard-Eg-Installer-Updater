package Tk::Wizard::Eg::Installer::Updater;

=head1 NAME

Tk::Wizard::Eg::Installer::Updater

=head1 DESCRIPTION

Just an example script for you to read.

=head1 AUTHOR

Lee Goddard <lgoddard@cpan.org>
26 June 2003

=head1 COPYRIGHT

Copyright (C) Lee Goddard, 2003 - No Rights Reserved.
No warranty, gaurantess or anything else, either.

=cut

our $VERSION = 1.0;					# This script
our $PRODUCT = "myplace";			# Product version
our $SUPPORT = 'update@myplace.com';# Support name/uri/text

use Carp;
use strict;
use warnings;

use Tk::Wizard::Installer;
use Tk::ErrorDialog;

my $wizard = new Tk::Wizard::Installer::Win32(
	-title			=> "Update $PRODUCT",
#	-imagepath		=> "setup/big.bmp",
#	-topimagepath	=> "setup/small.bmp",
	-style			=> 'top',
	-nohelpbutton	=> 1,
	-tag_text 		=> "$PRODUCT",
	-tag_width		=> 110,
);

$wizard->addPage( sub{ page_splash ($wizard) });

my $COPYRIGHT_PAGE = $wizard->addLicencePage( -filepath => "/myplace/end_user_licence.txt" ) ;

$wizard->addDownloadPage(
	-files	  => {
		"http://www.myplace/updates//myplace.pm"	=> "C:/myplace/myplace.exe",
	},
);

$wizard->addPage( sub{ page_finish ($wizard) });

$wizard -> configure (
	-finishButtonAction		=> sub { exit },
	-preNextButtonAction 	=> sub {
		$wizard->currentPage==$COPYRIGHT_PAGE? return $wizard->callback_licence_agreement : 1;
	},
);

$wizard->Show();
MainLoop;

exit;


sub page_splash  { my $wizard = shift;
	my $frame = $wizard->blank_frame(
		-title=>"Welcome to the $PRODUCT Update Wizard",
		-text=>"This wizard will update your copy of $PRODUCT to the latest version.\n\n
Press the Next button to continue, or Cancel to exit Setup.\n\n\n\n\n\n\n\n");
	return $frame;
}


sub page_finish { my $wizard = shift;
	my $frame;
	if ($wizard->{-failed}){
		$frame = $wizard->blank_frame(-title=>"$PRODUCT Update Failed",
			-text=>"
  The $PRODUCT update failed to install.\n\n  Please check your internet connection and try again
  or, for assistance, contact $SUPPORT"
		);
	} else {
		$frame = $wizard->blank_frame(-title=>"$PRODUCT Update Complete",
			-text=>"  The $PRODUCT update is now complete!\n\n  Please re-start your $PRODUCT for the update to take effect."
		);
	}
	$frame->Label(
		-font => $wizard->{defaultFont},
		qw/-background white -wraplength 400 -justify left/, -text =>
			"        Click the Finish button to exit Setup.\n\n\n\n\n\n\n\n\n"
		)->pack(qw/-anchor w -padx 20 -pady 10 /);
	$frame->pack(
		qw/-side top -anchor w -expand 1 -fill both /
	);
	return $frame;
}

__END__
