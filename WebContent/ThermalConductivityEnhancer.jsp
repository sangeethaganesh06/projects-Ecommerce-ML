<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thermal Conductivity Enhancer Tests</title>
    <style>
             body {
        font-family: Arial, sans-serif;
        background: url('adminPage/img/section-3-bg.jpg') no-repeat center center fixed;
        background-color: #f8f9fa;
        margin: 0;
        padding: 0;
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
            margin-left: 10%;
               margin-top: 3%;
              
        }
        button:hover {
            background-color: #45a049;
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
        .btn-animated {
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
    </style>
    <script>
    function calculateThermalConductivity() {
        var heatFlowRate = parseFloat(document.getElementById("heatFlowRate").value);
        var thickness = parseFloat(document.getElementById("thickness").value);
        var area = parseFloat(document.getElementById("area").value);
        var tempDifference = parseFloat(document.getElementById("tempDifference").value);
        if (!isNaN(heatFlowRate) && !isNaN(thickness) && !isNaN(area) && !isNaN(tempDifference)) {
            var thermalConductivity = (heatFlowRate * thickness) / (area * tempDifference);
            document.getElementById("modalContent").innerHTML = 
                "<h2>Thermal Conductivity Test</h2>" +
                "<p>Heat Flow Rate: " + heatFlowRate + " W</p>" +
                "<p>Thickness: " + thickness + " m</p>" +
                "<p>Area: " + area + " m²</p>" +
                "<p>Temperature Difference: " + tempDifference + " K</p>" +
                "<p>Thermal Conductivity: " + thermalConductivity.toFixed(2) + " W/m·K</p>" +
                "<form id='testForm'action='SubmitThermalControlEnhancerTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='ThermalConductivity'>" +
                "<input type='hidden' name='heatFlowRate' value='" + heatFlowRate + "'>" +
                "<input type='hidden' name='thickness' value='" + thickness + "'>" +
                "<input type='hidden' name='area' value='" + area + "'>" +
                "<input type='hidden' name='tempDifference' value='" + tempDifference + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all parameters.");
        }
    }

    function calculateThermalExpansion() {
        var changeInLength = parseFloat(document.getElementById("changeInLength").value);
        var originalLength = parseFloat(document.getElementById("originalLength").value);
        var tempChange = parseFloat(document.getElementById("tempChange").value);
        if (!isNaN(changeInLength) && !isNaN(originalLength) && !isNaN(tempChange)) {
            var thermalExpansion = changeInLength / (originalLength * tempChange);
            document.getElementById("modalContent").innerHTML = 
                "<h2>Thermal Expansion Test</h2>" +
                "<p>Change in Length: " + changeInLength + " m</p>" +
                "<p>Original Length: " + originalLength + " m</p>" +
                "<p>Temperature Change: " + tempChange + " K</p>" +
                "<p>Thermal Expansion: " + thermalExpansion.toFixed(2) + " m/K</p>" +
                "<form id='testForm' action='SubmitThermalControlEnhancerTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='ThermalExpansion'>" +
                "<input type='hidden' name='changeInLength' value='" + changeInLength + "'>" +
                "<input type='hidden' name='originalLength' value='" + originalLength + "'>" +
                "<input type='hidden' name='tempChange' value='" + tempChange + "'>" +
                "<input type='hidden' name='thermalExpansion' value='" + thermalExpansion + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all parameters.");
        }
    }

    function calculateHeatTransferRate() {
        var heatTransferred = parseFloat(document.getElementById("heatTransferred").value);
        var tempDifference = parseFloat(document.getElementById("tempDifferenceHeat").value);
        if (!isNaN(heatTransferred) && !isNaN(tempDifference)) {
            var heatTransferRate = heatTransferred / tempDifference;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Heat Transfer Rate Test</h2>" +
                "<p>Heat Transferred: " + heatTransferred + " J</p>" +
                "<p>Temperature Difference: " + tempDifference + " K</p>" +
                "<p>Heat Transfer Rate: " + heatTransferRate.toFixed(2) + " J/K</p>" +
                "<form id='testForm' action='SubmitThermalControlEnhancerTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='HeatTransferRate'>" +
                "<input type='hidden' name='heatTransferred' value='" + heatTransferred + "'>" +
                "<input type='hidden' name='tempDifference' value='" + tempDifference + "'>" +
                "<input type='hidden' name='heatTransferRate' value='" + heatTransferRate + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all parameters.");
        }
    }

    function calculateThermalStability() {
        var initialWeight = parseFloat(document.getElementById("initialWeight").value);
        var finalWeight = parseFloat(document.getElementById("finalWeight").value);
        if (!isNaN(initialWeight) && !isNaN(finalWeight)) {
            var weightLoss = ((initialWeight - finalWeight) / initialWeight) * 100;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Thermal Stability Test</h2>" +
                "<p>Initial Weight: " + initialWeight + " g</p>" +
                "<p>Final Weight: " + finalWeight + " g</p>" +
                "<p>Weight Loss: " + weightLoss.toFixed(2) + "%</p>" +
                "<form id='testForm'action='SubmitThermalControlEnhancerTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='ThermalStability'>" +
                "<input type='hidden' name='initialWeight' value='" + initialWeight + "'>" +
                "<input type='hidden' name='finalWeight' value='" + finalWeight + "'>" +
                "<input type='hidden' name='weightLoss' value='" + weightLoss + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all parameters.");
        }
    }

    

    function calculateEnhancementRatio() {
        var enhancedConductivity = parseFloat(document.getElementById("enhancedConductivity").value);
        var baselineConductivity = parseFloat(document.getElementById("baselineConductivity").value);
        if (!isNaN(enhancedConductivity) && !isNaN(baselineConductivity)) {
            var enhancementRatio = enhancedConductivity / baselineConductivity;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Thermal Conductivity Enhancement Ratio</h2>" +
                "<p>Enhanced Conductivity: " + enhancedConductivity + " W/m·K</p>" +
                "<p>Baseline Conductivity: " + baselineConductivity + " W/m·K</p>" +
                "<p>Enhancement Ratio: " + enhancementRatio.toFixed(2) + "</p>" +
                "<form id='testForm' action='SubmitThermalControlEnhancerTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='EnhancementRatio'>" +
                "<input type='hidden' name='enhancedConductivity' value='" + enhancedConductivity + "'>" +
                "<input type='hidden' name='baselineConductivity' value='" + baselineConductivity + "'>" +
                "<input type='hidden' name='enhancementRatio' value='" + enhancementRatio + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all parameters.");
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
<button class="btn-animated"  onclick="window.location.href='material_types.jsp?material=<%= request.getParameter("material") %>'">Back</button>
    
   <h1>TEST DETAILS FOR <%= request.getParameter("material").toUpperCase() %> - <%= request.getParameter("typeOfMaterial").toUpperCase() %></h1>
   
 
    <div class="test-inputs">
        <h2>Thermal Conductivity Test</h2>
        <input type="number" id="heatFlowRate" placeholder="Heat Flow Rate (W)" step="any">
        <input type="number" id="thickness" placeholder="Thickness (m)" step="any">
        <input type="number" id="area" placeholder="Area (m²)" step="any">
        <input type="number" id="tempDifference" placeholder="Temperature Difference (K)" step="any">
        <button class="btn-animated" onclick="calculateThermalConductivity()">Calculate</button>
    </div>

    <div class="test-inputs">
        <h2>Thermal Expansion Test</h2>
        <input type="number" id="changeInLength" placeholder="Change in Length (m)" step="any">
        <input type="number" id="originalLength" placeholder="Original Length (m)" step="any">
        <input type="number" id="tempChange" placeholder="Temperature Change (K)" step="any">
        <button class="btn-animated" onclick="calculateThermalExpansion()">Calculate</button>
    </div>

    <div class="test-inputs">
        <h2>Heat Transfer Rate Test</h2>
        <input type="number" id="heatTransferred" placeholder="Heat Transferred (J)" step="any">
        <input type="number" id="tempDifferenceHeat" placeholder="Temperature Difference (K)" step="any">
        <button class="btn-animated" onclick="calculateHeatTransferRate()">Calculate</button>
    </div>

    <div class="test-inputs">
        <h2>Thermal Stability Test</h2>
        <input type="number" id="initialWeight" placeholder="Initial Weight (g)" step="any">
        <input type="number" id="finalWeight" placeholder="Final Weight (g)" step="any">
        <button class="btn-animated" onclick="calculateThermalStability()">Calculate</button>
    </div>

    

    <div class="test-inputs">
        <h2>Thermal Conductivity Enhancement Ratio</h2>
        <input type="number" id="enhancedConductivity" placeholder="Enhanced Conductivity (W/m·K)" step="any">
        <input type="number" id="baselineConductivity" placeholder="Baseline Conductivity (W/m·K)" step="any">
        <button onclick="calculateEnhancementRatio()">Calculate</button>
    </div>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <div id="modalContent"></div>
        </div>
    </div>
</body>
</html>
