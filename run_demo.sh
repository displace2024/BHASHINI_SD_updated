## Path variables
sd_folder=/data1/apoorvak/SD_SID_combined/Updated_demo/speaker_diarization_demo
input_folder=/data1/apoorvak/SD_SID_combined/Updated_demo/input
output_folder=/data1/apoorvak/SD_SID_combined/Updated_demo/output

echo "####################################################################"
echo "Ensure input wav files are present in the path given in the script"
echo "Ensure path variables are set correctly"
echo "####################################################################"

## Run SD demo model
for file in "$input_folder"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        nameonly="${filename%.wav}"
        cd $sd_folder
        ./run_spectral_file.sh $file $nameonly
        cd ..
        cp $sd_folder/exp/${nameonly}_diarization_vbhmm_spectral/per_file_rttm/${nameonly}.rttm $output_folder
    fi
done

echo "RTTMs from the SD model are present in the output folder"