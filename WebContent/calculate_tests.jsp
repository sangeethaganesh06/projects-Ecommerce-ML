<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Material Testing Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .test-inputs {
            margin: 10px 0;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            width: 60%;
            margin: 20px auto;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: relative;
        }
        .test-inputs input, .test-inputs button {
            margin: 5px;
            padding: 10px;
            border: 1px solid #ddd;
        }
        .test-inputs button.submit {
            position: absolute;
            right: 10px;
            bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #45a049;
        }.btn-animated {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .btn-animated:hover {
            transform: scale(1.1);
        }
        .btn-animated:active {
            transform: scale(1);
        }
        /* Modal Styles */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
            padding-top: 60px; 
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
            position: relative;
        }
        .close {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 25px;
            font-size: 35px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
  
    <script>
    function calculateDurability() {
        var initialMass = parseFloat(document.getElementById("initialMass").value);
        var finalMass = parseFloat(document.getElementById("finalMass").value);
        if (!isNaN(initialMass) && !isNaN(finalMass)) {
            var durabilityLoss = ((initialMass - finalMass) / initialMass) * 100;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Durability Test</h2>" +
                "<p>Initial Mass: " + initialMass + " g</p>" +
                "<p>Final Mass: " + finalMass + " g</p>" +
                "<p>Durability Loss: " + durabilityLoss.toFixed(2) + " %</p>" +
                "<form id='testForm' action='SubmitBinderTest.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Durability'>" +
                "<input type='hidden' name='initialMass' value='" + initialMass + "'>" +
                "<input type='hidden' name='finalMass' value='" + finalMass + "'>" +
                "<input type='hidden' name='durabilityLoss' value='" + durabilityLoss + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both mass values.");
        }
    }

    function calculateDensity() {
        var mass = parseFloat(document.getElementById("densityMass").value);
        var volume = parseFloat(document.getElementById("densityVolume").value);
        if (!isNaN(mass) && !isNaN(volume) && volume > 0) {
            var density = mass / volume;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Density Test</h2>" +
                "<p>Mass: " + mass + " kg</p>" +
                "<p>Volume: " + volume + " cm³</p>" +
                "<p>Density: " + density.toFixed(2) + " kg/cm³</p>" +
                "<form id='testForm' action='SubmitBinderTest.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Density'>" +
                "<input type='hidden' name='mass' value='" + mass + "'>" +
                "<input type='hidden' name='volume' value='" + volume + "'>" +
                "<input type='hidden' name='density' value='" + density + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for mass and volume.");
        }
    }

    function calculateFlexuralStrength() {
        var load = parseFloat(document.getElementById("flexuralLoad").value);
        var spanLength = parseFloat(document.getElementById("flexuralSpanLength").value);
        var width = parseFloat(document.getElementById("flexuralWidth").value);
        var depth = parseFloat(document.getElementById("flexuralDepth").value);
        if (!isNaN(load) && !isNaN(spanLength) && !isNaN(width) && !isNaN(depth) && width > 0 && depth > 0) {
            var flexuralStrength = (3 * load * spanLength) / (2 * width * depth * depth);
            document.getElementById("modalContent").innerHTML = 
                "<h2>Flexural Strength Test</h2>" +
                "<p>Load: " + load + " N</p>" +
                "<p>Span Length: " + spanLength + " mm</p>" +
                "<p>Width: " + width + " mm</p>" +
                "<p>Depth: " + depth + " mm</p>" +
                "<p>Flexural Strength: " + flexuralStrength.toFixed(2) + " MPa</p>" +
                "<form id='testForm' action='SubmitBinderTest.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='FlexuralStrength'>" +
                "<input type='hidden' name='load' value='" + load + "'>" +
                "<input type='hidden' name='spanLength' value='" + spanLength + "'>" +
                "<input type='hidden' name='width' value='" + width + "'>" +
                "<input type='hidden' name='depth' value='" + depth + "'>" +
                "<input type='hidden' name='flexuralStrength' value='" + flexuralStrength + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all flexural strength parameters.");
        }
    }

    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }



    </script>
</head>
<body>

    <button  class="btn-animated" onclick="window.location.href='material_types.jsp?material=<%= request.getParameter("material") %>'">Back</button>
    
    <h1>Testing Details for <%= request.getParameter("material") %> : <%= request.getParameter("typeOfMaterial") %></h1>
    <div class="test-inputs">
        <%
            String material = request.getParameter("material");
            String typeOfMaterial = request.getParameter("typeOfMaterial");

            if (material != null && !material.isEmpty() && typeOfMaterial != null && !typeOfMaterial.isEmpty()) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ricehuskinsulation", "root", "root");

                    String sql = "SELECT Amount_per_sqft FROM material_requirement WHERE Material = ? AND Type_of_Material = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, material);
                    stmt.setString(2, typeOfMaterial);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        double amountPerSqft = rs.getDouble("Amount_per_sqft");

                        if ("Binder".equalsIgnoreCase(material)) {
                            %>
                            <h2>Durability Test</h2>
                            <input type="number" id="initialMass" placeholder="Initial Mass (g)">
                            <input type="number" id="finalMass" placeholder="Final Mass (g)">
                            <button class="btn-animated" onclick="calculateDurability()">Calculate Durability</button> 
                            
                            <h2>Density Test</h2>
                            <input type="number" id="densityMass" value="<%= amountPerSqft %>" readonly>
                            <input type="number" id="densityVolume" placeholder="Volume (cm³)">
                            <button class="btn-animated" onclick="calculateDensity()">Calculate Density</button>

                            <h2>Flexural Strength Test</h2>
                            <input type="number" id="flexuralLoad" placeholder="Load (N)">
                            <input type="number" id="flexuralSpanLength" placeholder="Span Length (mm)">
                            <input type="number" id="flexuralWidth" placeholder="Width (mm)">
                            <input type="number" id="flexuralDepth" placeholder="Depth (mm)">
                            <button class="btn-animated" onclick="calculateFlexuralStrength()">Calculate Flexural Strength</button>
                            <% 
                        } 
                        else if ("MoistureControlAgent".equalsIgnoreCase(material)) {
                        	// Set an attribute in the request
                        	request.setAttribute("material",material );
                        	request.setAttribute("typeOfMaterial",typeOfMaterial);
                        	// Redirect to another page
                        	RequestDispatcher dispatcher = request.getRequestDispatcher("MoistureControlAgentCalculation.jsp");
                        	dispatcher.forward(request, response);

                            }
                        else if ("ThermalConductivityEnhancer".equalsIgnoreCase(material)) {
                        	// Set an attribute in the request
                        	request.setAttribute("material",material );
                        	request.setAttribute("typeOfMaterial",typeOfMaterial);
                        	// Redirect to another page
                        	RequestDispatcher dispatcher = request.getRequestDispatcher("ThermalConductivityEnhancer.jsp");
                        	dispatcher.forward(request, response);

                            }
                        else if ("NewsPaper Cellulose".equalsIgnoreCase(material)) {
                        	// Set an attribute in the request
                        	request.setAttribute("material",material );
                        	request.setAttribute("typeOfMaterial",typeOfMaterial);
                        	// Redirect to another page
                        	RequestDispatcher dispatcher = request.getRequestDispatcher("CelluloseCalculations.jsp");
                        	dispatcher.forward(request, response);

                            }
                        else {
                            out.println("<p>Tests are not applicable for the selected material type.</p>");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>No material or type of material specified.</p>");
            }
        %>
    </div>

    <div id="myModal" class="modal">
        <div class="modal-content" id="modalContent">
            <!-- Results will be inserted here -->
            <span class="close" onclick="closeModal()">&times;</span>
        </div>
    </div>
</body>
</html>
