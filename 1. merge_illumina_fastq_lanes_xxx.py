#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 28 13:33:01 2018

@author: morgan
"""
#--- libraries
import os
import re
import shutil

#--- path to the directory where your fastq files are
direct = "/path/to/fastq/file/"

#--- file name patterns that you want to separate out
pattern_list = [".*24I.*_R1.*", 
                ".*24I.*_R2.*", 
                ".*24J.*_R1.*",
                ".*24J.*_R2.*",
                ".*24K.*_R1.*",
                ".*24K.*_R2.*",
                ".*24L.*_R1.*",
                ".*24L.*_R2.*",
                ".*48I.*_R1.*",
                ".*48I.*_R2.*",
                ".*48J.*_R1.*",
                ".*48J.*_R2.*",
                ".*48K.*_R1.*",
                ".*48K.*_R2.*",
                ".*48L.*_R1.*",
                ".*48L.*_R2.*"]

#--- make a list of all the files in the directory (find files recursively)
fastq_files  = []
for root, dirs, files in os.walk(direct):
    for file in files:
        if file.endswith(".fastq.gz"):
             fastq_files.append(os.path.join(root, file))

#--- split file names by sample and read direction
listlist = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
for filename in fastq_files:
    for pattern, listname in zip(pattern_list, listlist):
        if re.match(pattern, filename): 
            listname.append(filename)

         
#--- make sure that results are correct
i = 0
for listname in listlist:
    i+=1
    print("\n\n\n list", i, ":  \n",)
    for filename in listname:
        print(filename)
    
#--- concatenate the files in each list to one file
def write_catted(libraries_list, pattern_list, output_dir, cleanup=False):
    """Write out concatenated files by sample."""
    for pattern,listname in zip(pattern_list, libraries_list):
        sample_id = re.sub('[_.*-]', '', pattern[2:5])
        read_direc = re.sub("[.R_*]", "", pattern[7:10])
        outfile = os.path.join(output_dir, 'XXX_%s_%s.fastq.gz' % (sample_id, read_direc))
        print("\n\n", outfile)
        for files in listname: 
            print("\n", files)
        
        x = input("continue? (y or n)")
        if x == "y":
            catted = open(outfile, 'wb')
            destinations = [(catted, listname)]
            for dest, files in destinations:
                for fpath in files:               
                    f = open(fpath, 'rb')
                    shutil.copyfileobj(f, dest)
                    f.close()
                dest.close()
                if cleanup:
                    for fpath in files:
                        os.remove(fpath)
        else:
            break
            
        
write_catted(listlist, pattern_list, "/path/to/save/merged/files/reads/")

















