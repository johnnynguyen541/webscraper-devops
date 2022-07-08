# MODULES/FEATURES USED IN FEATURE

resource "aws_instance" "ec2_singular" {
  # REQUIRED VARIABLES
  ami                                  = var.ami
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  subnet_id                            = var.subnet_id
  vpc_security_group_ids               = var.vpc_security_group_ids

  # OPTIONAL VARIABLES
  associate_public_ip_address          = var.associate_public_ip_address
  availability_zone                    = var.availability_zone
  capacity_reservation_specification   = var.capacity_reservation_specification 
  cpu_core_count                       = var.cpu_core_count 
  cpu_threads_per_core                 = var.cpu_threads_per_core 
  credit_specification                 = var.credit_specification 
  disable_api_stop                     = var.disable_api_stop 
  disable_api_termination              = var.disable_api_termination
  ebs_block_device                     = var.ebs_block_device
  ebs_optimized                        = var.ebs_optimized
  enclave_options_enabled              = var.enclave_options_enabled
  ephemeral_block_device               = var.ephemeral_block_device
  get_password_data                    = var.get_password_data
  hibernation                          = var.hibernation
  host_id                              = var.host_id
  iam_instance_profile                 = var.iam_instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  ipv6_address_count                   = var.ipv6_address_count
  ipv6_addresses                       = var.ipv6_addresses
  launch_template                      = var.launch_template
  maintenance_options                  = var.maintenance_options
  metadata_options                     = var.metadata_options
  monitoring                           = var.monitoring
  network_interface                    = var.network_interface
  placement_group                      = var.placement_group
  placement_partition_number           = var.placement_partition_number
  private_dns_name_options             = var.private_dns_name_options
  private_ip                           = var.private_ip
  root_block_device                    = var.root_block_device
  secondary_private_ips                = var.secondary_private_ips
  source_dest_check                    = var.source_dest_check
  timeouts                             = var.timeouts
  tenancy                              = var.tenancy
  user_data                            = var.user_data
  user_data_base64                     = var.user_data_base64
  user_data_replace_on_change          = var.user_data_replace_on_change
  volume_tags                          = var.volume_tags
  
  # TAGS
  tags = var.tags
}
