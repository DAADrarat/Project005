package lx.project.calendar.config;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletRegistration;

public class PjWebInitializer implements WebApplicationInitializer{

	
		@Override
		public void onStartup(ServletContext servletContext) {
			AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
			rootContext.register(SpringConfig.class);
			servletContext.addListener(new ContextLoaderListener(rootContext));
			
			AnnotationConfigWebApplicationContext webContext = new AnnotationConfigWebApplicationContext();
			webContext.register(WebMvcConfig.class);
			
			ServletRegistration.Dynamic sd = servletContext.addServlet("dispatcher", new DispatcherServlet(webContext));
			sd.setLoadOnStartup(1);
			sd.addMapping("/");
			
		}

		
		
}
