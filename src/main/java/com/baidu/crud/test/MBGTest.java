package com.baidu.crud.test;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;
/*
 * mybatis逆向工程执行程序
 */
public class MBGTest {

	public static void main(String[] args) throws IOException, XMLParserException, SQLException, InterruptedException, InvalidConfigurationException {
		ArrayList<String> warnings=new ArrayList<String>();
		boolean overwrite=true;
		File configFile=new File("mbg.xml");
		ConfigurationParser cp=new ConfigurationParser(warnings);
		Configuration config= cp.parseConfiguration(configFile);
		DefaultShellCallback callback=new DefaultShellCallback(overwrite);
		MyBatisGenerator myBatisGenerator=new MyBatisGenerator(config, callback, warnings);
		myBatisGenerator.generate(null);
		System.out.println("完成");
	}
}
