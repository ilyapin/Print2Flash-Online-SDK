DROP TABLE IF EXISTS `p2ffile`;
CREATE TABLE `p2ffile` ( `id` CHAR(32) NOT NULL, `origname` VARCHAR(128) NOT NULL, `origsize` INT NOT NULL DEFAULT '0', `origcontenttype` varchar(64) DEFAULT NULL, `ext` VARCHAR(8) NOT NULL, `ip` VARCHAR(24) DEFAULT NULL, `time_uploaded` INT NOT NULL, PRIMARY KEY (`id`) );

DROP TABLE IF EXISTS `p2fconv`;
CREATE TABLE `p2fconv`( `id` CHAR(32) NOT NULL, `fileid` CHAR(32) NOT NULL, `status` CHAR(1) NOT NULL, `docformat` CHAR(1) NOT NULL DEFAULT 'B', `time_converted` INT NOT NULL, PRIMARY KEY (`id`), FOREIGN KEY(fileid) REFERENCES `p2ffile`(id) ON UPDATE CASCADE ON DELETE CASCADE );
CREATE INDEX `idxStatusTimeU` ON `p2fconv` ( `status`, `time_converted` );

DROP TABLE IF EXISTS `p2fconverror`;
CREATE TABLE `p2fconverror`(`convid` CHAR(32) NOT NULL, `error` TEXT NOT NULL, PRIMARY KEY(convid), FOREIGN KEY(convid) REFERENCES `p2fconv`(id) ON UPDATE CASCADE ON DELETE CASCADE )

