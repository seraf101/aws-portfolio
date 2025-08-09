############################################################
# Terraform の基本設定
############################################################
terraform {
  # Terraform のバージョン指定
  # 1.6.0 以上で動作（将来の互換性を考慮してバージョン縛りを設定）
  required_version = ">= 1.6.0"

  # 必要なプロバイダ（AWSなど）を定義
  required_providers {
    aws = {
      # AWSプロバイダは公式の "hashicorp/aws" を利用
      source  = "hashicorp/aws"
      # AWSプロバイダのバージョン（5系を利用）
      version = "~> 5.0"
    }
  }
}

############################################################
# AWS プロバイダの設定
############################################################
provider "aws" {
  # 利用するリージョン（デフォルトは東京リージョン）
  region  = var.aws_region

  # AWS CLI で設定したプロファイル名
  # → このプロファイルに設定されたアクセスキー/シークレットキーを使用
  profile = var.aws_profile
}

############################################################
# 変数定義（variables.tfに分けてもOK）
############################################################

# デフォルトリージョン
variable "aws_region" {
  description = "AWS リージョン名"
  type        = string
  default     = "ap-northeast-1"  # 東京リージョン
}

# 使用するAWS CLIプロファイル
variable "aws_profile" {
  description = "AWS CLIで設定したプロファイル名"
  type        = string
  default     = "aws-portfolio"
}

# プロジェクト名（タグや命名で利用）
variable "project_name" {
  description = "プロジェクト名（タグ付けやリソース名のPrefixに利用）"
  type        = string
  default     = "aws-container-portfolio"
}

# 全リソース共通のタグ
variable "common_tags" {
  description = "全リソースに付与する共通タグ"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "sohta"
  }
}

############################################################
# （任意）接続確認用 data ソース
# Day1 と同様、動作確認目的。不要なら削除可
############################################################

# 自分のAWSアカウント情報を取得
data "aws_caller_identity" "me" {}

# 現在のリージョン情報を取得
data "aws_region" "current" {}

############################################################
# 出力設定
# terraform apply 後に表示される値
############################################################

# AWSアカウントID
output "account_id" {
  description = "AWSアカウントID"
  value       = data.aws_caller_identity.me.account_id
}

# 使用リージョン
output "region" {
  description = "現在のリージョン"
  value       = data.aws_region.current.name
}
