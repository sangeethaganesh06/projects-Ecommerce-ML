<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Moisture Control Agent Tests</title>
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
            margin-top: 5%;
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
    function calculateMoistureAbsorption() {
        var initialWeight = parseFloat(document.getElementById("initialWeight").value);
        var finalWeight = parseFloat(document.getElementById("finalWeight").value);
        if (!isNaN(initialWeight) && !isNaN(finalWeight)) {
            var moistureAbsorption = ((finalWeight - initialWeight) / initialWeight) * 100;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Moisture Absorption Test</h2>" +
                "<p>Initial Weight: " + initialWeight + " grams</p>" +
                "<p>Final Weight: " + finalWeight + " grams</p>" +
                "<p>Moisture Absorption: " + moistureAbsorption.toFixed(2) + " %</p>" +
                "<form id='testForm' action='SubmitMoistureAgentTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='MoistureAbsorption'>" +
                "<input type='hidden' name='initialWeight' value='" + initialWeight + "'>" +
                "<input type='hidden' name='finalWeight' value='" + finalWeight + "'>" +
                "<input type='hidden' name='moistureAbsorption' value='" + moistureAbsorption.toFixed(2) + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both weight values.");
        }
    }

    function calculateWVTR() {
        var changeInMass = parseFloat(document.getElementById("changeInMass").value);
        var area = parseFloat(document.getElementById("area").value);
        var time = parseFloat(document.getElementById("time").value);
        if (!isNaN(changeInMass) && !isNaN(area) && !isNaN(time) && area > 0 && time > 0) {
            var wvtr = changeInMass / (area * time);
            document.getElementById("modalContent").innerHTML = 
                "<h2>Water Vapor Transmission Rate (WVTR) Test</h2>" +
                "<p>Change in Mass: " + changeInMass + " grams</p>" +
                "<p>Area: " + area + " m²</p>" +
                "<p>Time: " + time + " hours</p>" +
                "<p>WVTR: " + wvtr.toFixed(2) + " g/m²·h</p>" +
                "<form id='testForm' action='SubmitMoistureAgentTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='WVTR'>" +
                "<input type='hidden' name='changeInMass' value='" + changeInMass + "'>" +
                "<input type='hidden' name='area' value='" + area + "'>" +
                "<input type='hidden' name='time' value='" + time + "'>" +
                "<input type='hidden' name='wvtr' value='" + wvtr.toFixed(2) + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for all WVTR parameters.");
        }
    }

    function calculateSwelling() {
        var initialThickness = parseFloat(document.getElementById("initialThickness").value);
        var finalThickness = parseFloat(document.getElementById("finalThickness").value);
        if (!isNaN(initialThickness) && !isNaN(finalThickness) && initialThickness > 0) {
            var swellingPercentage = ((finalThickness - initialThickness) / initialThickness) * 100;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Swelling Test</h2>" +
                "<p>Initial Thickness: " + initialThickness + " mm</p>" +
                "<p>Final Thickness: " + finalThickness + " mm</p>" +
                "<p>Swelling Percentage: " + swellingPercentage.toFixed(2) + " %</p>" +
                "<form id='testForm' action='SubmitMoistureAgentTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Swelling'>" +
                "<input type='hidden' name='initialThickness' value='" + initialThickness + "'>" +
                "<input type='hidden' name='finalThickness' value='" + finalThickness + "'>" +
                "<input type='hidden' name='swellingPercentage' value='" + swellingPercentage.toFixed(2) + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both thickness values.");
        }
    }

    function calculateShrinkage() {
        var originalDimension = parseFloat(document.getElementById("originalDimension").value);
        var finalDimension = parseFloat(document.getElementById("finalDimension").value);
        if (!isNaN(originalDimension) && !isNaN(finalDimension) && originalDimension > 0) {
            var shrinkagePercentage = ((originalDimension - finalDimension) / originalDimension) * 100;
            document.getElementById("modalContent").innerHTML = 
                "<h2>Shrinkage Test</h2>" +
                "<p>Original Dimension: " + originalDimension + " mm</p>" +
                "<p>Final Dimension: " + finalDimension + " mm</p>" +
                "<p>Shrinkage Percentage: " + shrinkagePercentage.toFixed(2) + " %</p>" +
                "<form id='testForm' action='SubmitMoistureAgentTestResults.jsp' method='post'>" +
                "<input type='hidden' name='testType' value='Shrinkage'>" +
                "<input type='hidden' name='originalDimension' value='" + originalDimension + "'>" +
                "<input type='hidden' name='finalDimension' value='" + finalDimension + "'>" +
                "<input type='hidden' name='shrinkagePercentage' value='" + shrinkagePercentage.toFixed(2) + "'>" +
                "<button type='submit' class='submit'>Submit Results</button>" +
                "</form>" +
                "<button class='close' onclick='closeModal()'>×</button>";
            openModal();
        } else {
            alert("Please enter valid numbers for both dimension values.");
        }
    }

    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
    }

    window.onclick = function(event) {
        var modal = document.getElementById("myModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    </script>
</head>
<body>
<button class="btn-animated" onclick="window.location.href='material_types.jsp?material=<%= request.getParameter("material") %>'">Back</button>
    <h1>MOISTURE CONTROL AGENT TEST</h1>
    <div class="test-inputs">
        <h2>Moisture Absorption Test</h2>
        <label for="initialWeight">Initial Weight (g):</label>
        <input type="number" id="initialWeight" name="initialWeight"><br>
        <label for="finalWeight">Final Weight (g):</label>
        <input type="number" id="finalWeight" name="finalWeight"><br>
        <button class="btn-animated" onclick="calculateMoistureAbsorption()">Calculate Moisture Absorption</button>
    </div>
    <div class="test-inputs">
        <h2>Water Vapor Transmission Rate (WVTR) Test</h2>
        <label for="changeInMass">Change in Mass (g):</label>
        <input type="number" id="changeInMass" name="changeInMass"><br>
        <label for="area">Area (m²):</label>
        <input type="number" id="area" name="area"><br>
        <label for="time">Time (h):</label>
        <input type="number" id="time" name="time"><br>
        <button class="btn-animated" onclick="calculateWVTR()">Calculate WVTR</button>
    </div>
    <div class="test-inputs">
        <h2>Swelling Test</h2>
        <label for="initialThickness">Initial Thickness (mm):</label>
        <input type="number" id="initialThickness" name="initialThickness"><br>
        <label for="finalThickness">Final Thickness (mm):</label>
        <input type="number" id="finalThickness" name="finalThickness"><br>
        <button class="btn-animated" onclick="calculateSwelling()">Calculate Swelling</button>
    </div>
    <div class="test-inputs">
        <h2>Shrinkage Test</h2>
        <label for="originalDimension">Original Dimension (mm):</label>
        <input type="number" id="originalDimension" name="originalDimension"><br>
        <label for="finalDimension">Final Dimension (mm):</label>
        <input type="number" id="finalDimension" name="finalDimension"><br>
        <button class="btn-animated" onclick="calculateShrinkage()">Calculate Shrinkage</button>
    </div>

    <!-- The Modal -->
    <div id="myModal" class="modal">
        <!-- Modal content -->
        <div class="modal-content" id="modalContent">
            <!-- Modal content will be injected here by JavaScript -->
        </div>
    </div>
</body>
</html>
