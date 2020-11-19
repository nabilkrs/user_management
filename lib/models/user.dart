class User{
int id;
String name;
String email;
String phone;

User(dynamic object){
id=object['id'];
name=object['name'];
email=object['email'];
phone=object['phone'];


}
User.other({this.name,this.email,this.phone,this.id});



User.fromMap(Map<String,dynamic> data){
id=data['id'];
name=data['name'];
email=data['email'];
phone=data['phone'];

}
Map<String, dynamic> toMap()=>{'id':id,'name':name,'email':email,'phone':phone};





}