package kr.or.ddit.testenv;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	   "classpath:kr/or/ddit/config/spring/application-datasource.xml",
   	   "classpath:kr/or/ddit/config/spring/application-transaction.xml",
	   "classpath:kr/or/ddit/config/spring/root-context.xml"
		})
public class LogicTestEnv {
	
	@Ignore
	@Test
	public void dummy() {
		
	}
	
}
