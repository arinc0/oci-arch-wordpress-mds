# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 
data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = local.instance_shape
  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_identity_availability_domains" "ADs" {

  compartment_id = var.compartment_ocid

}

data "oci_core_shapes" "matched_shapes" {
  compartment_id      = var.compartment_ocid
  availability_domain = local.availability_domain_name

  # filter{
  #   name = "name"
  #   values = local.compute_flexible_shapes
  # }

  filter {
    name   = "name"
    values = [local.flexible_shape_regex]
    regex  = true
  }
}

