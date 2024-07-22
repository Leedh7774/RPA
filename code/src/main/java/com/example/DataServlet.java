package com.example;

import java.io.IOException;
import java.util.Arrays;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/submit")
public class DataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] productNames = request.getParameterValues("productName[]");
        String[] textures = request.getParameterValues("texture[]");
        String[] grades = request.getParameterValues("grade[]");
        String[] productWeights = request.getParameterValues("productWeight[]");
        String[] srWeights = request.getParameterValues("srWeight[]");
        String[] equipmentTonnages = request.getParameterValues("equipmentTonnage[]");
        String[] equipmentNumbers = request.getParameterValues("equipmentNumber[]");
        
        request.setAttribute("productNames", productNames != null ? productNames : new String[0]);
        request.setAttribute("textures", textures != null ? textures : new String[0]);
        request.setAttribute("grades", grades != null ? grades : new String[0]);
        request.setAttribute("productWeights", productWeights != null ? productWeights : new String[0]);
        request.setAttribute("srWeights", srWeights != null ? srWeights : new String[0]);
        request.setAttribute("equipmentTonnages", equipmentTonnages != null ? equipmentTonnages : new String[0]);
        request.setAttribute("equipmentNumbers", equipmentNumbers != null ? equipmentNumbers : new String[0]);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/success.jsp");
        dispatcher.forward(request, response);
    }
}

