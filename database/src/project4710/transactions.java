package project4710;
public class transactions{
	protected int trans_id;
	protected String from_user;
 	protected String to_user;
    protected char trans_type;
    protected String trans_time;
    protected double price;
    
    //constructors
    public transactions() {
    }
    public transactions(int trans_id){
        this.trans_id = trans_id;
    }
    public transactions(int trans_id, String from_user, String to_user, char trans_type, String trans_time, double price) {
        this(from_user, to_user, trans_type, trans_time, price);
        this.trans_id = trans_id;
    }
    public transactions(String from_user, String to_user, char trans_type, String trans_time, double price) {
        this.from_user = from_user;
        this.to_user = to_user;
        this.trans_type = trans_type;
        this.trans_time = trans_time;
        this.price = price;
    }

    //getter and setter methods
    public int getID() {
        return trans_id;
    }
    public void setID(int trans_id) {
        this.trans_id = trans_id;
    }
    
    public String getFrom() {
        return from_user;
    }
    public void setFrom(String from_user) {
        this.from_user = from_user;
    }
    
    public String getTo() {
        return to_user;
    }
    public void setTo(String to_user) {
        this.to_user = to_user;
    }

    public String getTime() {
        return trans_time;
    }
    public void setTime(String trans_time) {
        this.trans_time = trans_time;

    } public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public char getType() {
        return trans_type;
    }
    public void setType(char trans_type) {
        this.trans_type = trans_type;
    }
}