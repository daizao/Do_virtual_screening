#!/usr/bin/perl -w
use strict;
use warnings;
use Cwd;

my $dir=getcwd;
opendir(DIR,$dir) || die "no this dir";
my @first_file=readdir(DIR);
close(DIR);

my @doc;	# store the gene doc;

for my $i (0..$#first_file){
	if($first_file[$i] =~ /\.+$/){next};
	if (-d $first_file[$i]){
		push(@doc,$first_file[$i]);
	}
}

my @lig_name;
open(WF,">total_temp.txt") || die $!;
print WF "Molname\t"."Target\t"."Energy\n";
for my $i (0..$#doc){
	my $lig_path=$dir."/".$doc[$i]."/lig_file";
#	print $lig_path; 
	opendir(DIR,$lig_path) || die "do not have the lig_path";
	@lig_name=readdir(DIR);
	close(DIR);
	for my $j (0..$#lig_name){
		if($lig_name[$j] =~ /\.+$/){next};
		if($lig_name[$j] =~/ /){next};
		my $old_lig_name = $lig_name[$j];
		$lig_name[$j] =~ /(.*?).pdbqt/;
#		print $1."\n";
		my $log_path=$dir."/".$doc[$i]."/".$1."/".$1."_log.txt";
		my $temp=$1;
#		print $log_path."\n";
		open(RF,$log_path) || die "no lig_log path";
		while(my $line=<RF>){
			chomp($line);
			if($line =~ /\s+1\s/){ #get the minnum energy data;
				my @arr=split(/\s+/,$line);
				print WF $temp."\t".$doc[$i]."\t".$arr[2]."\n";
				}
		}
		close(RF);
	}
}
close(WF);

open(WF,">final_total_energy.txt") || die $!;

my %hash_energy;
my @list;
my $hang=0;

open(RF,"total_temp.txt") || die "do not have total_temp.txt";
while(my $line=<RF>){
	chomp($line);
	if($.==1){
		my @head=split(/\t/,$line);
		print WF $head[0]."\t".$head[1]."\t".$head[2]."\n";
		next;
		};
	my @arr=split(/\t/,$line);
#	$hash_energy{$arr[2]}="$arr[0]\t$arr[1]";
	for my $i (0..$#arr){
		$list[$hang][$i]=$arr[$i];
		}
	$hang=$hang+1;
}
close(RF);

@list=sort{$a -> [2] <=>$b -> [2]} @list;

for my $i (0..$#list){
	for my $j (0..$#{$list[$i]}){
		print WF $list[$i][$j]."\t";
	}
	print WF "\n";
}

#for my $key (sort {$a <=> $b}keys %hash_energy){
#		print WF $key."\t".$hash_energy{$key}."\n";
#	}
#close(WF);

my %lig_name_hash;
open(RF,"dict_lig_name.txt") || die "do not have dit_lig_name file";
while(my $line=<RF>){
	chomp ($line);
	my @arr=split(/\t/,$line);
	$lig_name_hash{$arr[1]}=$arr[0];
}
close(RF);

open(RF,"final_total_energy.txt") || die "no final_total_energy.txt";
open(WF,">final_sort_energy.txt") || die $!;
while(my $line=<RF>){
	chomp($line);
	if($.==1){print WF "Mol_old_name\t".$line."\n";next};
	my @arr=split(/\t/,$line);
	if(exists $lig_name_hash{$arr[0]}){
		print WF $lig_name_hash{$arr[0]}."\t".join("\t",@arr)."\n";
	}	
}
close(RF);
close(WF);


unlink "total_temp.txt";
unlink "dict_lig_name.txt";
unlink "final_total_energy.txt";

