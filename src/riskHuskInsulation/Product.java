package riskHuskInsulation;
public class Product {
    private String productId;
    private String productName;
    private float costPerUnit;

    public Product(String productId, String productName, float costPerUnit) {
        this.productId = productId;
        this.productName = productName;
        this.costPerUnit = costPerUnit;
    }

    // Getters and setters
    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public float getCostPerUnit() {
        return costPerUnit;
    }

    public void setCostPerUnit(float costPerUnit) {
        this.costPerUnit = costPerUnit;
    }

	public double getAmount() {
		// TODO Auto-generated method stub
		return 0;
	}
}
