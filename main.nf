// Declare syntax version
nextflow.enable.dsl=2

command_string = params.command_string

process bcl2fastq {
  publishDir "${params.output_dir}", mode: 'copy', overwrite: true

  input:
    path input_dir
    val command_string

  output:
    file "*.fastq.gz"
    file "Reports"
    file "Stats"

    """
    ${command_string}
    """
}

workflow {
   def input_ch = Channel.fromPath(params.input_dir)
   bcl2fastq(input_ch)
}

