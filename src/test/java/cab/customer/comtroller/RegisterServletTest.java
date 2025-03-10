package cab.customer.comtroller;
import org.example.cab.customer.controller.RegisterServlet;
import org.example.cab.customer.dao.UserDAO;
import org.example.cab.customer.model.User;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class RegisterServletTest {

    @Test
    void testValidateEmail() {
        assertTrue(RegisterServlet.isValidEmail("test@example.com"));
        assertFalse(RegisterServlet.isValidEmail("invalid-email"));
    }

    @Test
    void testValidatePhoneNumber() {
        assertTrue(RegisterServlet.isValidPhoneNumber("0771234567"));
        assertFalse(RegisterServlet.isValidPhoneNumber("123"));
    }

    @Test
    void testValidateNIC() {
        assertTrue(RegisterServlet.isValidNIC("200012345678"));
        assertFalse(RegisterServlet.isValidNIC("abc123"));
    }
}
