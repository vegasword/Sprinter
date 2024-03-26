export namespace IClientSockets {
  
  export namespace Teacher {
    
    export interface AddSprint {
      name : string,
      start : string,
      end : string,
      classroom_id : number,
      teacher_id : number,
      techs : Array<string>
    }
    
  }
  
}
