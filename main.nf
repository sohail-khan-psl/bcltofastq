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
    bcl2fastq 
    """
}

workflow {
   def input_ch = Channel.fromPath(params.input_dir)
   bcl2fastq(input_ch)
}

