abstract class NewsAppState{}

class InitState extends NewsAppState{}

class ChangeButtonNavigatorBar extends NewsAppState{}

class getBusinessState extends NewsAppState{}

class getSportsState extends NewsAppState{}

class getScienceState extends NewsAppState{}

class getDataErrorState extends NewsAppState{
  final String error;
  getDataErrorState(this.error);
}

class getBusinessStateLoadingData extends NewsAppState{}

class GetDataWhenSearchState extends NewsAppState{}