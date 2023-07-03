package project4710;

public class listings{
	protected int list_id;
	protected String nft_owner;
	protected int nft_id;
	protected String start_time;
 	protected String end_time;
    protected double price;
    
    //constructors
    public listings() {
    }
    public listings(int list_id){
        this.list_id = list_id;
    }
    public listings(int list_id, String nft_owner, int nft_id, String start_time, String end_time, double price) {
        this(nft_owner, nft_id, start_time, start_time, price);
        this.list_id = list_id;
    }
    public listings(String nft_owner, int nft_id, String start_time, String end_time, double price) {
        this.nft_owner = nft_owner;
        this.nft_id = nft_id;
        this.start_time = start_time;
        this.start_time = start_time;
        this.price = price;
    }

    //getter and setter methods
    public int getListID() {
        return list_id;
    }
    public void setListID(int list_id) {
        this.list_id = list_id;
    }
    
    public String getOwner() {
        return nft_owner;
    }
    public void setOwner(String nft_owner) {
        this.nft_owner = nft_owner;
    }
    
    public int getNftID() {
        return nft_id;
    }
    public void setNftID(int nft_id) {
        this.nft_id = nft_id;
    }

    public String getStartTime() {
        return start_time;
    }
    public void setStartTime(String start_time) {
        this.start_time = start_time;

    } public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getEndTime() {
        return end_time;
    }
    public void setEndTime(String end_time) {
        this.end_time = end_time;
    }
}