## **Batch Virtual Screening Based on Vina**

### Please pay attention to the following issues before calculation
	1.Please make sure that the ligand file name is not too long.
	2.Prepare yourself's protein pdbqt and Grid box file.  
	3.Please pay attention to the placement rules of folders.
	4.Please put all the lig files (mol2 formula) in the same doc, and named lig_file.   
	5.Before you run this program, you shuld copy your data in a safe path.
	6.Make sure Open Babel is installed.
	7.The Linux version of Vina is compiled in the Centos 7 system. If you encounter an error in Vina on Linux, please recompile.

### Open Babel Website : [Open Babel](https://openbabel.org/)
### Open Babel install in Linux
```Bash
sudo dnf install openbabel -y

```

### Vina compilation reference : [Vina recompile](https://www.dzbioinformatics.com/2020/09/05/autodock-vina-%e6%ba%90%e7%a0%81%e7%bc%96%e8%af%91%e5%ae%89%e8%a3%85/)

### Run sample
```Perl
#Windows
perl run.pl

#Linux
perl -I /path/to/script run.pl	#The storage path of the script
```

### Finally, a scoring and sorting file of all proteins and their ligands will be obtained.
	Mol_old_name    Molname Target  Energy
	(2S)-2-[4-hydroxy-3-(3-methylbut-2-enyl)phenyl]-8,8     2S-2-4-hydroxy-3-3-methylbut-2-enylphenyl-8-8   MAPK14  -9.8
	(E)-1-(2,4-dihydroxyphenyl)-3-(2,2-dimethylchromen-6-yl)prop-2-en-1-one E-1-2-4-dihydroxyphenyl-3-2-2-dimethylchromen-6-ylprop-2-en-1-one       ESR1    -8.5
	Quercetin der   Quercetin_der   ESR1    -8.3
	ZINC105741014   ZINC105741014   MAPK14  -7.9


