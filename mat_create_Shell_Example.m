fid = fopen('CreateWhiteMatterTS.sh','wt');
sublist = {'12001','12002','12004'};  % My list of subject IDs to loop over
WhiteMatterSeedFilename = 'WhiteMatterSeed.nii';  % My white matter seed filename
% Now I loop over the three subjects, each time making a new input filename, output filename, and unix string with the correct subject ID
for isub = 1:length(sublist)
    infile = sprintf('%s_RestingState.nii.gz',sublist{isub});  % This is the input file name for fslmeants to use
    outfile = sprintf('%s_WhiteMatterTS.txt',sublist{isub});  % This is the output file name for fslmeants to use
    unixstr = sprintf('fslmeants -i %s -o %s -m %s;',infile,outfile,WhiteMatterSeedFilename);  % This is what I'm executing in the shell script.
    fprintf(fid,'%s\n',unixstr);  % This adds each line to the shell script
end % end my for loop
fclose(fid);