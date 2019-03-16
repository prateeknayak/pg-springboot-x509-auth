package msslserver;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.HashMap;

@RestController
public class HelloWorld {

    @PreAuthorize("hasAuthority('ROLE_USER')")
    @RequestMapping("/")
    public ResponseEntity<Object> helloworld(Principal principal) {

        HashMap<String, String> map = new HashMap<>();
        map.put("message", String.format("Hello Secure World! %s", principal.getName()));

        return new ResponseEntity<Object>(map, HttpStatus.OK);
    }


    @RequestMapping("/insecure")
    public  ResponseEntity<Object> insecure() {
        HashMap<String, String> map = new HashMap<>();
        map.put("message", "Hello Insecure World!");
        return new ResponseEntity<Object>(map, HttpStatus.OK);
    }

}
