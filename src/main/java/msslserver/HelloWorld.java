package msslserver;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@RestController
public class HelloWorld {

    @RequestMapping("/")
    public String index(Principal principal) {
        return String.format("Hello Secure World! mssl user:  %s", principal.getName());
    }

    @RequestMapping("/insecure")
    public String insecure() {
        return "Hello Insecure World!";
    }

}
