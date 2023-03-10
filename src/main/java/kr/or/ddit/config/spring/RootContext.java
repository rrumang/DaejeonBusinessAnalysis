package kr.or.ddit.config.spring;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

// kr/or/ddit/config/spring/root-context.xml을 자바 config로 변경
// @Service, @Repository annotation을 대상으로 스캔
//@ImportResource({"classpath:kr/or/ddit/config/spring/application-scheduler.xml",
//"classpath:kr/or/ddit/config/spring/application-batch.xml"})
@Configuration
@ComponentScan(basePackages = "kr.or.ddit", useDefaultFilters = false,
				includeFilters = @Filter(type = FilterType.ANNOTATION, classes = {Service.class, Repository.class}))
//useDefaultFilters = false 하지 않으면 bean이 과다 생성됨 => 리소스 낭비
public class RootContext {

}
