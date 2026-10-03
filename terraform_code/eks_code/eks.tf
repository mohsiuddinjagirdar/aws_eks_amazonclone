module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.26.0"

  name = local.name
  kubernetes_version = "1.33"
  
  endpoint_public_access = true

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

  eks_managed_node_groups = {
    panda-node = {
      min_size     = 2
      max_size     = 4
      desired_size = 2

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "Panda_Node"
      }
    }
  }

  tags = local.tags
}
