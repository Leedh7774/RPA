import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/result")
public class DBServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@Oracle1:1521:xe";
    private static final String DB_USER = "C##calc";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] productNames = request.getParameterValues("productNames");
        String[] totalWeights = request.getParameterValues("totalWeights");
        String[] materialPrices = request.getParameterValues("materialPrices");
        String[] totalMoneys = request.getParameterValues("totalMoneys");
        String[] textures = request.getParameterValues("textures");
        String[] grades = request.getParameterValues("grades");
        String[] productWeights = request.getParameterValues("productWeights");
        String[] srWeights = request.getParameterValues("srWeights");
        String[] equipmentTonnages = request.getParameterValues("equipmentTonnages");
        String[] equipmentNumbers = request.getParameterValues("equipmentNumbers");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String calc_sql = "INSERT INTO calcdata (proname, texture, grade, proweight, srweight, tonnage, cav) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(calc_sql)) {
                    for (int i = 0; i < productNames.length; i++) {
                        statement.setString(1, productNames[i]);
                        statement.setString(2, textures[i]);
                        statement.setString(3, grades[i]);
                        statement.setString(4, productWeights[i]);
                        statement.setString(5, srWeights[i]);
                        statement.setString(6, equipmentTonnages[i]);
                        statement.setString(7, equipmentNumbers[i]);
                        statement.executeUpdate();
                    }
                }
                String result_sql = "INSERT INTO Result (PRODUCT_NAME, TOTAL_WEIGHT, MATERIAL_PRICE, TOTAL_MONEY) VALUES (?, ?, ?, ?)";
                try (PreparedStatement statement = connection.prepareStatement(result_sql)) {
                    for (int i = 0; i < productNames.length; i++) {
                        statement.setString(1, productNames[i]);
                        statement.setString(2, totalWeights[i]);
                        statement.setString(3, materialPrices[i]);
                        statement.setString(4, totalMoneys[i]);
                        statement.executeUpdate();
                    }
                }
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new ServletException("error", e);
        }
    }
}

