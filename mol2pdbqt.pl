#!/usr/bin/perl -w

use strict;
use warnings;
use Cwd;
use File::Copy;

my $original_dir=getcwd;
my @all_file_name;
opendir(DIR,$original_dir) || die $!;
@all_file_name=readdir(DIR);
close(DIR);

my @gene_name;
for my $i (0..$#all_file_name){
	next if($all_file_name[$i]=~ /\.+$/);
	if(-d $all_file_name[$i]){
#		print $all_file_name[$i]."\n";
		push(@gene_name,$all_file_name[$i]);
	}
}


for my $i (0..$#gene_name){
	my $dir= "$original_dir/$gene_name[$i]/"."lig_file";
#	print $dir;
	my @drug_files;
	opendir(DIR,$dir) || die "no this dir";
	@drug_files = readdir(DIR);
	close(DIR);

	my @drug_mol2;

	for my $i (0..$#drug_files){
		next if($drug_files[$i]=~ /\.+$/);
		if ($drug_files[$i]=~ /mol2$/){
			push (@drug_mol2,$drug_files[$i]);
	#		print $drug_files[$i]."\n";
		}
	}


	if(!(-d "$dir/old_mol2_files")){
		mkdir ("$dir/old_mol2_files");
	}

	for my $i (0..$#drug_mol2){
		my @arr=split('\.',$drug_mol2[$i]);
	#	print $arr[0]."\n";
#		print "obabel -imol2 "."$dir"."$drug_mol2[$i]"." -opdbqt -O "."$dir"."$arr[0]".".pdbqt -h\n";
		print `obabel -imol2 "$dir/$drug_mol2[$i]" -opdbqt -O "$dir/$arr[0]".pdbqt -h`;
		move("$dir/$drug_mol2[$i]","$dir/old_mol2_files");
	}

}


