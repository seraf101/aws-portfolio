terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-northeast-1"   # 東京リージョン
  profile = "aws-portfolio"    # 先ほど設定したAWS CLIプロファイル名
}

# 自分のAWSアカウント情報を取得（課金なし）
data "aws_caller_identity" "me" {}

# 現在のリージョン情報を取得（課金なし）
data "aws_region" "current" {}

# 出力設定
output "account_id" {
  value = data.aws_caller_identity.me.account_id
}

output "region" {
  value = data.aws_region.current.name
}
