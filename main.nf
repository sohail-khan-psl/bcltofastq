// Declare syntax version
nextflow.enable.dsl=2

// Script parameters
params.input_dir

process bcl2fastq {
  publishDir "${params.output_dir}", mode: 'copy', overwrite: true

  input:
    path input_dir

  output:
    file "*.fastq.gz"
    file "Reports"
    file "Stats"

    """
    bcl2fastq \
        --use-bases-mask=${params.use_bases_mask} \
        --create-fastq-for-index-reads=${params.create_fastq_for_index_reads} \
        --minimum-trimmed-read-length=${params.minimum_trimmed_read_length} \
        --mask-short-adapter-reads=${params.mask_short_adapter_reads} \
        --ignore-missing-positions=${params.ignore_missing_positions} \
        --ignore-missing-controls=${params.ignore_missing_controls} \
        --ignore-missing-filter=${params.ignore_missing_filter} \
        --ignore-missing-bcls=${params.ignore_missing_bcls} \
        --runfolder-dir=${params.input_dir} \
        --output-dir=${params.output_dir} \
        --sample-sheet ${params.input_dir}/${params.sample_sheet} \
        --interop-dir ${params.input_dir}/InterOp \
        --input-dir ${params.input_dir}/Data/Intensities/BaseCalls \
        --stats-dir ./Stats \
        --reports-dir ./Reports \
        --no-lane-splitting=${params.no_lane_splitting}
    """
}

workflow {
   def input_ch = Channel.fromPath(params.input_dir)
   bcl2fastq(input_ch)
}
