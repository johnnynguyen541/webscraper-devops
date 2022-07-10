# MODULES/FEATURES USED IN FEATURE

resource "aws_instance" "ec2_singular" {
  # NOTE - BASED ON LINK:
  # https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/

  # REQUIRED VARIABLES
  ami                                  = var.ami
  instance_type                        = var.instance_type
  key_name                             = var.key_name
  subnet_id                            = var.subnet_id
  vpc_security_group_ids               = var.vpc_security_group_ids

  # OPTIONAL VARIABLES
  associate_public_ip_address          = var.associate_public_ip_address
  availability_zone                    = var.availability_zone
  cpu_core_count                       = var.cpu_core_count 
  cpu_threads_per_core                 = var.cpu_threads_per_core 
  disable_api_stop                     = var.disable_api_stop 
  disable_api_termination              = var.disable_api_termination
  ebs_optimized                        = var.ebs_optimized
  get_password_data                    = var.get_password_data
  hibernation                          = var.hibernation
  host_id                              = var.host_id
  iam_instance_profile                 = var.iam_instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  ipv6_address_count                   = var.ipv6_address_count
  ipv6_addresses                       = var.ipv6_addresses
  monitoring                           = var.monitoring
  placement_group                      = var.placement_group
  placement_partition_number           = var.placement_partition_number
  private_ip                           = var.private_ip
  secondary_private_ips                = var.secondary_private_ips
  source_dest_check                    = var.source_dest_check
  tenancy                              = var.tenancy
  user_data                            = var.user_data
  user_data_base64                     = var.user_data_base64
  user_data_replace_on_change          = var.user_data_replace_on_change
  volume_tags                          = var.volume_tags

  # OPTIONAL VARIABLES - BLOCK DEFINITIONS
  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_specification != null ? [var.capacity_reservation_specification] : []
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", [])
        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }

  enclave_options {
    enabled = var.enclave_options_enabled
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "launch_template" {
    for_each = var.launch_template != null ? [var.launch_template] : []
    content {
      id      = lookup(var.launch_template, "id", null)
      name    = lookup(var.launch_template, "name", null)
      version = lookup(var.launch_template, "version", null)
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", "enabled")
      http_tokens                 = lookup(metadata_options.value, "http_tokens", "optional")
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", "1")
      instance_metadata_tags      = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", false)
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags                  = lookup(root_block_device.value, "tags", null)
    }
  }

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
  }

  # TAGS
  tags = var.tags

  # UNSUPPORTED
  # credit_specification
  # maintenance_options
  # private_dns_name_options
}
