/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3307
 Source Schema         : exchange

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 24/08/2023 18:12:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL,
  `status` bit(1) NOT NULL COMMENT '账号状态：0-冻结；1-正常；',
  `balance_amount` decimal(21, 8) NOT NULL,
  `freeze_amount` decimal(21, 8) NOT NULL,
  `recharge_amount` decimal(21, 8) NOT NULL,
  `withdrawals_amount` decimal(21, 8) NOT NULL,
  `net_value` decimal(21, 8) NOT NULL,
  `look_margin` decimal(21, 8) NOT NULL,
  `float_profit` decimal(21, 8) NOT NULL,
  `total_profit` decimal(21, 8) NOT NULL,
  `rec_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值地址',
  `version` bigint NOT NULL COMMENT '版本号',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户财产记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for account_detail
-- ----------------------------
DROP TABLE IF EXISTS `account_detail`;
CREATE TABLE `account_detail`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL COMMENT '币种id',
  `account_id` bigint NOT NULL COMMENT '账户id',
  `ref_account_id` bigint NOT NULL COMMENT '该笔流水资金关联方的账户id',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `direction` bit(1) NOT NULL COMMENT '出入款：1-入账；2-出账；',
  `biz_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务类型：recharge_info-充值；withdrawals_out-提现审核通过；order_create-下单；order_turnover-成交；order_turnover_poundage-成交手续费；order_cancel-撤销订单；bonus_register-注册奖励；withdrawals-提币冻结解冻；recharge-充值人民币；withdrawal_poundage-提币手续费；cny_btcx_exchange-兑换；bonus_info-奖励充值；bonus_freeze-奖励冻结；',
  `amount` decimal(41, 20) NOT NULL COMMENT '资产数量',
  `fee` decimal(41, 20) NULL DEFAULT NULL COMMENT '手续费',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流水状态：充值 提现 冻结 解冻 转出 转入',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_bank
-- ----------------------------
DROP TABLE IF EXISTS `admin_bank`;
CREATE TABLE `admin_bank`  (
  `id` bigint NOT NULL,
  `owner_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡持有人姓名',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡开户行名称',
  `bank_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `coin_id` bigint NULL DEFAULT NULL COMMENT '充值转换币种id',
  `coin_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种名称',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态：0-无效；1-有效；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '人民币充值卡号管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cash_recharge
-- ----------------------------
DROP TABLE IF EXISTS `cash_recharge`;
CREATE TABLE `cash_recharge`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL,
  `coin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种：cny，人民币',
  `num` decimal(20, 2) NOT NULL,
  `fee` decimal(20, 2) NOT NULL,
  `feecoin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手续费币种',
  `mum` decimal(20, 2) NULL DEFAULT NULL COMMENT '成交量(到账金额)',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付渠道：alipay-支付宝；cai1pay-财易付 ；bank-银联；weichat-微信；',
  `tradeno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值订单号',
  `outtradeno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方订单号',
  `remark` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值备注',
  `audit_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核备注',
  `step` bit(1) NULL DEFAULT NULL COMMENT '当前审核级数',
  `status` bit(1) NOT NULL COMMENT '状态：0-待审核；1-审核通过；2-拒绝；3-充值成功；',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡账户名',
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户行',
  `bank_card` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `last_time` datetime NOT NULL COMMENT '最后确认到账时间',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cash_recharge_audit_record_copy1
-- ----------------------------
DROP TABLE IF EXISTS `cash_recharge_audit_record_copy1`;
CREATE TABLE `cash_recharge_audit_record_copy1`  (
  `id` bigint NOT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `step` bit(1) NULL DEFAULT NULL,
  `audit_user_id` bigint NULL DEFAULT NULL,
  `audit_user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值审核记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cash_withdrawals
-- ----------------------------
DROP TABLE IF EXISTS `cash_withdrawals`;
CREATE TABLE `cash_withdrawals`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL,
  `account_id` bigint NOT NULL,
  `num` decimal(21, 2) NOT NULL COMMENT '提现金额数量',
  `fee` decimal(21, 2) NOT NULL COMMENT '手续费',
  `mum` decimal(21, 2) NOT NULL COMMENT '到账金额',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开户人',
  `bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '银行名称',
  `bank_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行所在省份',
  `bank_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行所在城市',
  `bank_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行所在地址',
  `bank_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `step` bit(1) NULL DEFAULT NULL COMMENT '当前审核级数',
  `status` bit(1) NOT NULL COMMENT '状态：0-待审核；1-审核通过；2-拒绝；3-提现成功；',
  `last_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '确认到账时间',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cash_withdrawals_audit_record
-- ----------------------------
DROP TABLE IF EXISTS `cash_withdrawals_audit_record`;
CREATE TABLE `cash_withdrawals_audit_record`  (
  `id` bigint NOT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `step` bit(1) NULL DEFAULT NULL,
  `audit_user_id` bigint NULL DEFAULT NULL,
  `audit_user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值审核记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin
-- ----------------------------
DROP TABLE IF EXISTS `coin`;
CREATE TABLE `coin`  (
  `id` bigint NOT NULL DEFAULT 0,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种标题',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种logo',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'xnb-人民币；default-比特币；ETH-以太坊；ETHToken-以太坊代币；',
  `wallet` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'rgb-认购币；qbb-钱包币；',
  `round` tinyint NOT NULL COMMENT '小数位',
  `base_amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '最小提现数量',
  `min_amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '单笔最小提现数量',
  `max_amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '单笔最大提现数量',
  `daily_max_amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '当日最大提现数量',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '状态：0-禁用；1-启用；',
  `min_fee_num` decimal(21, 8) NULL DEFAULT NULL COMMENT '最低收取手续费个数',
  `auto_out` double(23, 0) NULL DEFAULT NULL COMMENT '自动转出数量',
  `rate` double(23, 0) NULL DEFAULT NULL COMMENT '自动转出数量',
  `withdraw_enable` bit(1) NULL DEFAULT b'1' COMMENT '提现开关',
  `recharge_enable` bit(1) NULL DEFAULT b'1' COMMENT '充值开关',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_balance
-- ----------------------------
DROP TABLE IF EXISTS `coin_balance`;
CREATE TABLE `coin_balance`  (
  `id` bigint NOT NULL,
  `coin_id` bigint NULL DEFAULT NULL COMMENT '币种id',
  `coin_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种名称',
  `system_balance` decimal(21, 8) NULL DEFAULT NULL COMMENT '系统余额-根据充值提币计算',
  `coin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种类型',
  `collection_account_balance` decimal(21, 8) NULL DEFAULT NULL COMMENT '归集账户余额',
  `loan_account_balance` decimal(21, 8) NULL DEFAULT NULL COMMENT '钱包账户余额',
  `fee_account_balance` decimal(21, 8) NULL DEFAULT NULL COMMENT '手续费账户余额（eth提现需要手续费）',
  `recharge_account_balance` decimal(21, 8) NULL DEFAULT NULL COMMENT '充值账户余额',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '币种余额' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_config
-- ----------------------------
DROP TABLE IF EXISTS `coin_config`;
CREATE TABLE `coin_config`  (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种名称',
  `coin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种类型：btc-比特币系列；ethToken-以太坊系列；etc-以太经典；',
  `credit_limit` decimal(21, 8) NULL DEFAULT NULL COMMENT '钱包最低留存的币数量',
  `credit_limit_max` decimal(21, 8) NULL DEFAULT NULL COMMENT '当触发状态的时候，开始归集',
  `rpc_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'rpc服务ip',
  `rpc_port` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'rpc服务端口',
  `rpc_user` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'rpc用户',
  `rpc_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'rpc密码',
  `last_block` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '最后一个区块',
  `wallet_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '钱包用户名',
  `wallet_pass` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '钱包密码',
  `contract_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代币合约地址',
  `context` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'CONTEXT',
  `min_confirm` int NULL DEFAULT 1 COMMENT '最低确认数',
  `task` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '定时任务',
  `status` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否可用：0-否；1-是；',
  `auto_draw_limit` decimal(21, 8) NULL DEFAULT NULL,
  `auto_draw` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '币种配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_recharge
-- ----------------------------
DROP TABLE IF EXISTS `coin_recharge`;
CREATE TABLE `coin_recharge`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL,
  `coin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种名称',
  `coin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种类型',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包地址',
  `confirm` int NOT NULL COMMENT '充值确认数',
  `status` bit(1) NULL DEFAULT b'0' COMMENT '充值状态：0-1待入账；1-充值失败；2-到账失败；3-到账成功',
  `txid` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易id',
  `amount` decimal(21, 8) NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_server
-- ----------------------------
DROP TABLE IF EXISTS `coin_server`;
CREATE TABLE `coin_server`  (
  `id` bigint NOT NULL,
  `rpc_ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包服务器ip',
  `rpc_port` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包武器端口',
  `running` bit(1) NOT NULL COMMENT '服务是否运行：0-正常；1-停止；',
  `wallet_number` bigint NOT NULL COMMENT '服务器区块高度',
  `coin_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `real_number` bigint NULL DEFAULT NULL COMMENT '真实区块高度',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_type
-- ----------------------------
DROP TABLE IF EXISTS `coin_type`;
CREATE TABLE `coin_type`  (
  `id` bigint NOT NULL,
  `code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` bit(1) NOT NULL COMMENT '状态：0-无效；1-有效；',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `coin_withdraw`;
CREATE TABLE `coin_withdraw`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin_id` bigint NOT NULL,
  `coin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `coin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `txid` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `num` decimal(21, 8) NOT NULL COMMENT '提现量',
  `fee` decimal(21, 8) NOT NULL COMMENT '手续费',
  `mum` decimal(21, 8) NOT NULL COMMENT '实际提现',
  `type` bit(1) NULL DEFAULT NULL COMMENT '提币渠道：0-站内；1-其他；2-手工提币；',
  `chain_fee` decimal(21, 8) NULL DEFAULT NULL COMMENT '链上手续费',
  `block_num` int NULL DEFAULT NULL COMMENT '区块高度',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后台审核人员备注',
  `wallet_mark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户提币备注',
  `step` tinyint NULL DEFAULT NULL COMMENT '当前审核级数',
  `status` bit(1) NOT NULL COMMENT '状态：0-审核中；1-成功；2-拒绝；3-撤销；4-审核通过；5-打币中；',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for coin_withdraw_audit_record
-- ----------------------------
DROP TABLE IF EXISTS `coin_withdraw_audit_record`;
CREATE TABLE `coin_withdraw_audit_record`  (
  `id` bigint NOT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `step` tinyint NULL DEFAULT NULL,
  `audit_user_id` bigint NULL DEFAULT NULL,
  `audit_user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint NOT NULL,
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置规则类型',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置规则代码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置规则名称',
  `descripiton` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置规则描述',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置规则值',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平台配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for entrust_order
-- ----------------------------
DROP TABLE IF EXISTS `entrust_order`;
CREATE TABLE `entrust_order`  (
  `id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `market_id` bigint NOT NULL COMMENT '市场id',
  `market_type` bit(1) NULL DEFAULT NULL COMMENT '市场类型：1-币币交易；2-创新交易；',
  `symbol` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对标识符',
  `market_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易市场名称',
  `price` decimal(41, 20) NOT NULL COMMENT '委托价格',
  `merge_low_price` decimal(41, 20) NULL DEFAULT NULL COMMENT '合并深度价格1',
  `merge_high_price` decimal(41, 20) NULL DEFAULT NULL COMMENT '合并深度价格2',
  `volume` decimal(41, 20) NOT NULL COMMENT '委托数量',
  `amount` decimal(41, 20) NOT NULL COMMENT '委托总额',
  `fee_rate` decimal(41, 20) NOT NULL COMMENT '手续费比率',
  `deal` decimal(41, 20) NOT NULL COMMENT '成交数量',
  `freezed` decimal(41, 20) NOT NULL COMMENT '冻结数量',
  `margin_rate` decimal(41, 20) NULL DEFAULT NULL COMMENT '保证金比例',
  `base_coin_rate` decimal(41, 20) NULL DEFAULT NULL COMMENT '基础货币对（USDT/BTC）兑换率',
  `price_coin_rate` decimal(41, 20) NULL DEFAULT NULL COMMENT '基础货币对（USDT/BTC）兑换率',
  `lock_margin` decimal(41, 20) NULL DEFAULT NULL COMMENT '	占用保证金',
  `constract_unit` int NULL DEFAULT NULL COMMENT '合约单位',
  `price_type` tinyint NOT NULL DEFAULT 2 COMMENT '价格类型：1-市场价；2-限价；',
  `trade_type` tinyint NULL DEFAULT NULL COMMENT '交易类型：1-开仓；2-平仓；',
  `type` tinyint NULL DEFAULT NULL COMMENT '买卖类型：1-买入；2-卖出；',
  `open_order_id` bigint NULL DEFAULT NULL COMMENT '平仓委托关联单号',
  `status` tinyint(1) NOT NULL COMMENT '订单状态：0-未成交；1-已成交；2-已取消；3-异常单；',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fee` decimal(41, 20) NOT NULL COMMENT '交易手续费',
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '委托订单信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forex_account
-- ----------------------------
DROP TABLE IF EXISTS `forex_account`;
CREATE TABLE `forex_account`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `market_id` bigint NULL DEFAULT NULL COMMENT '交易对id',
  `market_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对',
  `direction` bit(1) NULL DEFAULT NULL COMMENT '持仓方向：1-买；2-卖；',
  `amount` decimal(21, 8) NULL DEFAULT 0.00000000 COMMENT '持仓量',
  `freezed_amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '冻结持仓量',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态：0-锁定；1-有效；',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '创新交易持仓信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forex_account_detail
-- ----------------------------
DROP TABLE IF EXISTS `forex_account_detail`;
CREATE TABLE `forex_account_detail`  (
  `id` bigint NOT NULL,
  `account_id` bigint NULL DEFAULT NULL COMMENT '持仓账户id',
  `type` bit(1) NULL DEFAULT NULL COMMENT '收支类型：1-开仓；2-平仓；',
  `amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '持仓量',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '持仓账户流水' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forex_close_position_order
-- ----------------------------
DROP TABLE IF EXISTS `forex_close_position_order`;
CREATE TABLE `forex_close_position_order`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `market_id` bigint NULL DEFAULT NULL COMMENT '交易对id',
  `account_id` bigint NULL DEFAULT NULL COMMENT '资金账户id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '成交订单id',
  `entrust_order_id` bigint NULL DEFAULT NULL COMMENT '委托订单id',
  `market_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对名称',
  `direction` bit(1) NULL DEFAULT NULL COMMENT '持仓方向：1-买；2-卖；',
  `price` decimal(21, 8) NULL DEFAULT NULL COMMENT '成交价',
  `num` decimal(21, 8) NULL DEFAULT NULL COMMENT '成交数量',
  `open_id` bigint NULL DEFAULT NULL COMMENT '关联开仓订单号',
  `profit` decimal(21, 8) NULL DEFAULT NULL COMMENT '平仓盈亏',
  `unlock_margin` decimal(21, 8) NULL DEFAULT NULL COMMENT '返回保证金',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平仓详情' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forex_coin
-- ----------------------------
DROP TABLE IF EXISTS `forex_coin`;
CREATE TABLE `forex_coin`  (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` tinyint NOT NULL DEFAULT 0 COMMENT '排序',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '状态：0-禁用；1-启用；',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '创新交易币种表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for forex_open_position_order
-- ----------------------------
DROP TABLE IF EXISTS `forex_open_position_order`;
CREATE TABLE `forex_open_position_order`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `coin_id` bigint NULL DEFAULT NULL COMMENT '币种id',
  `market_id` bigint NULL DEFAULT NULL COMMENT '交易对id',
  `account_id` bigint NULL DEFAULT NULL COMMENT '资金账户id',
  `order_id` bigint NULL DEFAULT NULL COMMENT '成交订单id',
  `entrust_order_id` bigint NULL DEFAULT NULL COMMENT '委托订单id',
  `market_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对名称',
  `direction` bit(1) NULL DEFAULT NULL COMMENT '持仓方向：1-买；2-卖；',
  `price` decimal(21, 8) NULL DEFAULT NULL COMMENT '成交价',
  `num` decimal(21, 8) NULL DEFAULT 0.00000000 COMMENT '成交数量',
  `open_id` bigint NULL DEFAULT NULL COMMENT '关联开仓订单号',
  `profit` decimal(21, 8) NULL DEFAULT NULL COMMENT '平仓盈亏',
  `lock_margin` decimal(21, 8) NULL DEFAULT 0.00000000 COMMENT '返回保证金',
  `close_num` decimal(21, 8) NULL DEFAULT 0.00000000 COMMENT '平仓量',
  `status` bit(1) NULL DEFAULT b'0' COMMENT '状态：0-未平仓；1-已平仓；',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '开仓订单信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for market
-- ----------------------------
DROP TABLE IF EXISTS `market`;
CREATE TABLE `market`  (
  `id` bigint NOT NULL COMMENT '市场id',
  `type` bit(1) NOT NULL COMMENT '类型：1-数字货币；2-创新交易',
  `trade_area_id` bigint NOT NULL COMMENT '交易区域id',
  `sell_coin_id` bigint NOT NULL COMMENT '卖方市场id',
  `buy_coin_id` bigint NOT NULL COMMENT '买方币种id',
  `symbol` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对标识',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市场logo',
  `open_price` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `fee_buy` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `fee_sell` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `margin_rate` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `num_min` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `num_max` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `trade_min` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `trade_max` decimal(21, 8) NOT NULL COMMENT '开盘价格',
  `point_value` decimal(21, 8) NULL DEFAULT NULL COMMENT '开盘价格',
  `price_scale` tinyint NULL DEFAULT 0 COMMENT '价格小数位',
  `num_scale` tinyint NOT NULL DEFAULT 0 COMMENT '数量小数位',
  `contract_unit` int NULL DEFAULT NULL COMMENT '合约单位',
  `merge_depth` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '合并深度（格式：4,3,2）4:表示为0.0001；3：表示为0.001',
  `trade_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易时间',
  `trade_week` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易周期',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `status` bit(1) NOT NULL COMMENT '状态：0-禁用；1-启用；',
  `fxcm_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '福汇api交易对',
  `yahoo_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '雅虎金融api交易对',
  `aliyun_symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里云api交易对',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `udpated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mine_pool
-- ----------------------------
DROP TABLE IF EXISTS `mine_pool`;
CREATE TABLE `mine_pool`  (
  `id` bigint NOT NULL,
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  `status` bit(1) NULL DEFAULT b'0' COMMENT '状态',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '矿池' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mine_pool_member
-- ----------------------------
DROP TABLE IF EXISTS `mine_pool_member`;
CREATE TABLE `mine_pool_member`  (
  `id` bigint NOT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint NULL DEFAULT NULL COMMENT '创建者',
  `mine_pool_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '矿池' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sms
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms`  (
  `id` bigint NOT NULL,
  `template_id` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信模板id',
  `country_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国际区号',
  `mobile` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信接受手机号',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信内容',
  `status` bit(1) NULL DEFAULT NULL COMMENT '短信状态：0-默认值；>0-成功发送次数;<0-异常',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL COMMENT '主键',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父菜单的id',
  `parent_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父菜单唯一key值',
  `type` tinyint NOT NULL DEFAULT 2 COMMENT '菜单类型：1-分类；2-节点；',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `target_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标地址',
  `sort` int NULL DEFAULT NULL COMMENT '排序索引',
  `status` tinyint NOT NULL COMMENT '菜单状态：0-无效；1-有效；',
  `created_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint NULL DEFAULT NULL COMMENT '修改人',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_privilege
-- ----------------------------
DROP TABLE IF EXISTS `sys_privilege`;
CREATE TABLE `sys_privilege`  (
  `id` bigint NOT NULL,
  `menu_id` bigint NULL DEFAULT NULL COMMENT '所属菜单id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限描述',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_by` bigint NULL DEFAULT NULL,
  `updated_by` bigint NULL DEFAULT NULL,
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态:0-禁用；1-启用；',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代码',
  `description` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `created_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint NULL DEFAULT NULL COMMENT '修改人',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint NOT NULL,
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `created_by` bigint NULL DEFAULT NULL,
  `updated_by` bigint NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_privilege`;
CREATE TABLE `sys_role_privilege`  (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `privilege_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_privilege_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_privilege_user`;
CREATE TABLE `sys_role_privilege_user`  (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `privilege_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL COMMENT '主键',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `fullname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '用户状态：0-无效；1-有效',
  `created_by` bigint NULL DEFAULT NULL COMMENT '创建人',
  `updated_by` bigint NOT NULL COMMENT '修改人',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_log`;
CREATE TABLE `sys_user_log`  (
  `id` bigint NOT NULL,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `type` smallint NULL DEFAULT NULL COMMENT '日志类型：1-查询；2-修改；3-新增；4-删除；5-导出；6-审核；',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参数',
  `time` bigint NULL DEFAULT NULL COMMENT '时间',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL,
  `role_id` bigint NULL DEFAULT NULL COMMENT '角色id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `created_by` bigint NULL DEFAULT NULL,
  `updated_by` bigint NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trade_area
-- ----------------------------
DROP TABLE IF EXISTS `trade_area`;
CREATE TABLE `trade_area`  (
  `id` bigint NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易区名称',
  `code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易区代码',
  `type` tinyint NULL DEFAULT NULL COMMENT '类型：1-数字货币交易；2-创新交易；',
  `coin_id` bigint NULL DEFAULT NULL COMMENT '结算币种id(仅创新交易需要使用)',
  `coin_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算币种名称',
  `sort` tinyint NULL DEFAULT NULL COMMENT '排序',
  `status` tinyint NULL DEFAULT NULL COMMENT '状态',
  `base_coin` bigint NULL DEFAULT NULL COMMENT '是否作为基础结算货币：0-否；1-是；供统计个人账户使用',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for turnover_order
-- ----------------------------
DROP TABLE IF EXISTS `turnover_order`;
CREATE TABLE `turnover_order`  (
  `id` bigint NOT NULL COMMENT '状态：0-带成交',
  `market_id` bigint NOT NULL,
  `sell_user_id` bigint NOT NULL,
  `sell_coin_id` bigint NOT NULL,
  `sell_order_id` bigint NOT NULL,
  `buy_user_id` bigint NOT NULL,
  `buy_coin_id` bigint NOT NULL,
  `buy_order_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `sell_price` decimal(41, 20) NOT NULL,
  `sell_fee_rate` decimal(41, 20) NOT NULL,
  `sell_volume` decimal(41, 20) NOT NULL,
  `buy_volume` decimal(41, 20) NOT NULL,
  `buy_price` decimal(41, 20) NOT NULL,
  `buy_fee_rate` decimal(41, 20) NOT NULL,
  `amount` decimal(41, 20) NOT NULL,
  `price` decimal(41, 20) NOT NULL,
  `volume` decimal(41, 20) NOT NULL,
  `deal_sell_fee` decimal(41, 20) NOT NULL,
  `deal_sell_fee_rate` decimal(41, 20) NOT NULL,
  `deal_buy_fee` decimal(41, 20) NOT NULL,
  `deal_buy_fee_rate` decimal(41, 20) NOT NULL,
  `market_type` int NULL DEFAULT NULL COMMENT '交易对类型：1-币币交易；2-创新交易；',
  `trade_type` bit(1) NOT NULL COMMENT '交易类型：1-买入；2-卖出；',
  `symbol` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对标识符',
  `market_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易对名称',
  `status` bit(1) NOT NULL COMMENT '状态：0-待成交；1-已成交；2-已撤销；3-异常；',
  `created_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for turnover_record
-- ----------------------------
DROP TABLE IF EXISTS `turnover_record`;
CREATE TABLE `turnover_record`  (
  `id` bigint NOT NULL,
  `market_id` bigint NOT NULL COMMENT '市场id',
  `price` decimal(21, 8) NOT NULL COMMENT '成交价',
  `volumn` decimal(21, 8) NOT NULL COMMENT '成交数量',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '成交数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL DEFAULT 1 COMMENT '用户类型：1-普通用户；2-代理用户；',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `country_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国际电话区号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `pin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易密码',
  `pin_status` bit(1) NULL DEFAULT b'0' COMMENT '交易密码状态：0-未设置；1-已设置；',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真是姓名',
  `id_card_type` bit(1) NOT NULL COMMENT '证件类型：0-其他；1-身份证；2-军(士)官(兵)证；3-护照；4-台湾通行证；5-港澳通行证；6-驾照；',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `auth_status` bit(1) NOT NULL COMMENT '认证状态：0-未认证；1-初级认证；2-中级认证；3-高级认证；',
  `ga_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '谷歌认证令牌秘钥',
  `ga_status` bit(1) NULL DEFAULT b'0' COMMENT '谷歌认证启用状态：0-未启用；1-启用；',
  `level` int NULL DEFAULT 0 COMMENT '代理级别',
  `auth_time` datetime NULL DEFAULT NULL COMMENT '认证时间',
  `signed_in_times` int NOT NULL DEFAULT 0 COMMENT '登录次数',
  `status` bit(1) NOT NULL DEFAULT b'0' COMMENT '用户状态：0-禁用；1-启用；',
  `invite_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邀请码',
  `invite_relation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '邀请关系',
  `invite_user_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邀请人id',
  `is_deductible` int NULL DEFAULT 0 COMMENT '是否开启平台币抵扣手续费：0-否；1-是；',
  `reviews_status` int NULL DEFAULT 0 COMMENT '审核状态：0-待审；1-通过；2-拒审',
  `merchant_rejected_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请代理商被拒原因',
  `access_key_id` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'API的key',
  `access_key_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'API秘钥',
  `ref_auth_id` bigint NULL DEFAULT NULL COMMENT '引用认证状态id',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_account_freezed
-- ----------------------------
DROP TABLE IF EXISTS `user_account_freezed`;
CREATE TABLE `user_account_freezed`  (
  `user_id` bigint NOT NULL,
  `freezed` decimal(41, 20) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻结用户金额' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户id',
  `coin_id` bigint NOT NULL COMMENT '币种id',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包地址',
  `keystore` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'keystore',
  `pwd` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `mark_id` bigint NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户钱包地址信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_address_error
-- ----------------------------
DROP TABLE IF EXISTS `user_address_error`;
CREATE TABLE `user_address_error`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户id',
  `coin_id` bigint NOT NULL COMMENT '币种id',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '钱包地址',
  `keystore` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'keystore',
  `pwd` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户钱包地址信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_auth_audit_log
-- ----------------------------
DROP TABLE IF EXISTS `user_auth_audit_log`;
CREATE TABLE `user_auth_audit_log`  (
  `id` bigint NOT NULL,
  `auth_code` bigint NULL DEFAULT NULL COMMENT '对应user_auth_info表的code',
  `user_id` bigint NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态：0-拒绝；1-同意；',
  `remark` varchar(10000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `step` tinyint NULL DEFAULT NULL COMMENT '当前审核级数',
  `audit_user_id` bigint NULL DEFAULT NULL COMMENT '审核id',
  `audit_user_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_auth_info
-- ----------------------------
DROP TABLE IF EXISTS `user_auth_info`;
CREATE TABLE `user_auth_info`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `image_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `serial_no` bit(1) NULL DEFAULT NULL COMMENT '序号：1-身份证正面照；2-身份证反面照；3-手持身份证照片',
  `auth_code` bigint NULL DEFAULT NULL COMMENT '用户每组审核记录唯一标识',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_bank
-- ----------------------------
DROP TABLE IF EXISTS `user_bank`;
CREATE TABLE `user_bank`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '银行卡对应的用户id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '银行卡名称',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户人',
  `bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户行',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户市',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开户地址（支行）',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '银行卡状态：0-禁用；1-启用；',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_coin_freezed
-- ----------------------------
DROP TABLE IF EXISTS `user_coin_freezed`;
CREATE TABLE `user_coin_freezed`  (
  `user_id` bigint NOT NULL,
  `coin_id` bigint NULL DEFAULT NULL,
  `freezed` decimal(11, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '冻结用户币种金额' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_favorite_market
-- ----------------------------
DROP TABLE IF EXISTS `user_favorite_market`;
CREATE TABLE `user_favorite_market`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `market_id` bigint NULL DEFAULT NULL COMMENT '交易对id',
  `type` bit(1) NULL DEFAULT NULL COMMENT '交易对类型：1-币币交易；2-创新交易；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户收藏交易市场' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_signed_in_log
-- ----------------------------
DROP TABLE IF EXISTS `user_signed_in_log`;
CREATE TABLE `user_signed_in_log`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `client_type` bit(1) NULL DEFAULT NULL COMMENT '客户端类型：1-WEB；2-H5；3-IOS；4-Android；5-desktop；',
  `ip` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录ip',
  `address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录地址',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_wallet
-- ----------------------------
DROP TABLE IF EXISTS `user_wallet`;
CREATE TABLE `user_wallet`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL COMMENT '用户id',
  `coin_id` bigint NOT NULL COMMENT '币种id',
  `coin_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种名称',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '提币地址名称',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `sort` int NOT NULL DEFAULT 0 COMMENT '排序',
  `status` bit(1) NOT NULL DEFAULT b'0' COMMENT '状态',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户提币地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wallet_collection_task
-- ----------------------------
DROP TABLE IF EXISTS `wallet_collection_task`;
CREATE TABLE `wallet_collection_task`  (
  `id` bigint NOT NULL,
  `coid_id` bigint NOT NULL COMMENT '币种id',
  `coin_type` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种类型',
  `coin_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种名称',
  `user_id` bigint NULL DEFAULT NULL COMMENT '归属那个用户',
  `txid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'txid',
  `amount` decimal(21, 8) NULL DEFAULT NULL COMMENT '归集数量',
  `chain_fee` decimal(21, 8) NULL DEFAULT NULL COMMENT '链上手续费',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否处理',
  `from_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来自哪个地址',
  `to_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转到哪个地址',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '当钱包需要归集的时候,会吧数据插入到该表,现在一般是用在eth和eth这类型需要归集的币种' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_config
-- ----------------------------
DROP TABLE IF EXISTS `web_config`;
CREATE TABLE `web_config`  (
  `id` bigint NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组：LINK_BANNER,WEB_BANNER',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '值',
  `sort` smallint NULL DEFAULT 1 COMMENT '排序权重',
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '连接地址',
  `status` bit(1) NOT NULL DEFAULT b'1' COMMENT '启用状态：0-禁用；1-启用；',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for work_issue
-- ----------------------------
DROP TABLE IF EXISTS `work_issue`;
CREATE TABLE `work_issue`  (
  `id` bigint NOT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '提问者的id',
  `answer_id` bigint NULL DEFAULT NULL COMMENT '回复者id',
  `answer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回复者名称',
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '工单内容',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '回答内容',
  `status` bit(1) NULL DEFAULT NULL COMMENT '状态:0-未答；1-已答；',
  `created_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
