#!/usr/bin/perl -w
use strict;
use warnings;
use Cwd;

my $dir=getcwd;
use get_os;
my $system_class=get_os::which_os();
#print $system_class;

print `perl mol2pdbqt.pl`;

my @first_file;

opendir(DIR,$dir) || die "no this dir";
@first_file=readdir(DIR);
close(DIR);
my $vina;
my @doc;


for my $i (0..$#first_file){
	if($first_file[$i] =~ /\.+$/){next};

## determine which system 
	if($system_class =~/Win/){
		if($first_file[$i] =~ /vina.exe$/){$vina=$dir."/".$first_file[$i]};
	}
	if($system_class =~/linux/){
		if($first_file[$i] =~ /vina$/){$vina=$dir."/".$first_file[$i]};
	}

	if (-d $first_file[$i]){
		push(@doc,$first_file[$i]);
	}
}
#print `$vina --help`;
#print @doc;

for my $i (0..$#doc){
	my $input_1=$dir."/".$doc[$i];
	my $input_2;
	opendir(DIR,$input_1) || die "can open $input_1";
	my @temp=readdir(DIR);	#get the file name in the gene doc
	close(DIR);
	for my $j (0..$#temp){
		if($temp[$j] =~ /\.+$/){next};
		if(-d $input_1."/".$temp[$j]){
			$input_2=$input_1."/".$temp[$j];
		}
	}
#	print $input_2;
	print `perl vina_analysis.pl $input_1 $input_2 $vina`;
}

print `perl get_min_energy_mol_list.pl`
