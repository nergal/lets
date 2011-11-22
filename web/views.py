from django.http import HttpResponse
from django.template import RequestContext, loader
from django.shortcuts import render_to_response


def home(request):
    data_dict = {'title': 'asdasd',}

    return render_to_response('main.html',
        data_dict,
        context_instance=RequestContext(request))

def callback(request):
    return None