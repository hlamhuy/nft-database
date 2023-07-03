package project4710;
public class nfts{
	protected int nft_id;
	protected String nft_name;
 	protected String url;
    protected String creator;
    protected String nft_owner;
    protected String mint_time;
    
    //constructors
    public nfts() {
    }

    public nfts(int nft_id){
        this.nft_id = nft_id;
    }
    public nfts(int nft_id, String nft_name, String url, String creator, String nft_owner, String mint_time) {
        this(nft_name, url, creator, nft_owner, mint_time);
        this.nft_id = nft_id;
    }
    public nfts(String nft_name, String url, String creator, String nft_owner, String mint_time) {
        this.nft_name = nft_name;
        this.url = url;
        this.creator = creator;
        this.nft_owner = nft_owner;
        this.mint_time = mint_time;
    }

    //getter and setter methods
    public int getID() {
        return nft_id;
    }
    public void setID(int nft_id) {
        this.nft_id = nft_id;
    }
    
    public String getName() {
        return nft_name;
    }
    public void setName(String nft_name) {
        this.nft_name = nft_name;
    }
    
    public String getURL() {
        return url;
    }
    public void setURL(String url) {
        this.url = url;
    }

    public String getCreator() {
        return creator;
    }
    public void setCreator(String creator) {
        this.creator = creator;

    } public String getOwner() {
        return nft_owner;
    }
    public void setOwner(String nft_owner) {
        this.nft_owner = nft_owner;
    }
    public String getMintTime() {
        return mint_time;
    }
    public void setMintTime(String mint_time) {
        this.mint_time = mint_time;
    }
}