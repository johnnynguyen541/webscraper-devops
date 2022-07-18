# INPUT DATA USED FOR TERRAFORM SCRIPT
data "template_file" "core_iam_policy" {
  template = "${file("${path.module}/iam_ec2_s3_access.tftpl")}"
}
