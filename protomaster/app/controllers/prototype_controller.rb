class PrototypeController < ApplicationController
before_action :define_left_menu
before_action :authenticate_user

  def new
    @proto = Prototype.new
  end

  def create
    #顧客情報がすでにある
    if client = Client.find_by(name: params[:client])
      #製品名がすでにある
      if pt_n = PrototypeName.find_by(name: params[:name])
        #マスターバッチ
        if pt_n.formtype == "masterbatch"
          flash[:notice] = "基本試作品情報を登録しました。"
          redirect_to("/prototype/#{pt_n.id}/new_mb")
        #ペーストカラー
        elsif pt_n.formtype == "pastecolor"
          flash[:notice] = "基本試作品情報を登録しました。"
          redirect_to("/prototype/#{pt_n.id}/new_pc")
        end
      #製品名新規登録
      else
        pt_n = PrototypeName.new(
          formtype:params[:formtype],
          name:params[:name],
          client:client.id
        )
        #製品名が正常に登録された場合
        if pt_n.save
          #マスターバッチ
          if pt_n.formtype == "masterbatch"
            flash[:notice] = "基本試作品情報を登録しました。"
            redirect_to("/prototype/#{pt_n.id}/new_mb")
          #ペーストカラー
          elsif pt_n.formtype == "pastecolor"
            flash[:notice] = "基本試作品情報を登録しました。"
            redirect_to("/prototype/#{pt_n.id}/new_pc")
          end
        #製品名が正常に登録されなかった場合
        else
          flash[:notice] = "基本情報が正常に保存されませんでした。"
          render("prototype/new")
        end
      end
    #顧客情報を新規に登録
    else
      client = Client.new(
        name:params[:client]
      )
      client.save
      #製品名がすでにある
      if pt_n = PrototypeName.find_by(name: params[:name])
        #マスターバッチ
        if pt_n.formtype == "masterbatch"
          flash[:notice] = "基本試作品情報を登録しました。"
          redirect_to("/prototype/#{pt_n.id}/new_mb")
        #ペーストカラー
        elsif pt_n.formtype == "pastecolor"
          flash[:notice] = "基本試作品情報を登録しました。"
          redirect_to("/prototype/#{pt_n.id}/new_pc")
        end
      #製品名新規登録
      else
        pt_n = PrototypeName.new(
          formtype:params[:formtype],
          name:params[:name],
          client:client.id
        )
        #製品名が正常に登録された場合
        if pt_n.save
          #マスターバッチ
          if pt_n.formtype == "masterbatch"
            flash[:notice] = "基本試作品情報を登録しました。"
            redirect_to("/prototype/#{pt_n.id}/new_mb")
          #ペーストカラー
          elsif pt_n.formtype == "pastecolor"
            flash[:notice] = "基本試作品情報を登録しました。"
            redirect_to("/prototype/#{pt_n.id}/new_pc")
          end
        #製品名が正常に登録されなかった場合
        else
          flash[:notice] = "基本情報が正常に保存されませんでした。"
          render("prototype/new")
        end
      end
    end
  end

  def new_mb
    @mb_n = PrototypeName.find_by(id: params[:id])
    @client = Client.find_by(id:@mb_n.client)
    @mb = Prototype.new
  end

  def new_pc
    @pc_n = PrototypeName.find_by(id: params[:id])
    @client = Client.find_by(id:@pc_n.client)
    @pc = Prototype.new
  end

  def update_mb
    mb_n = PrototypeName.find_by(id: params[:id])
    @mb = Prototype.new(
      formtype:mb_n.formtype,
      name:mb_n.id,
      client:mb_n.client,
      number:params[:number],
      measureDate:params[:measureDate],
      particle:params[:particle],
      conditions:params[:conditions],
      memo:params[:memo]
    )
    if @mb.save
      cv = Colorviewing.new(
        measureDate: params[:cv_measureDate],
        formtype: @mb.formtype,
        proto_id: @mb.id,
        number: @mb.number,
        comp: params[:cv_comp],
        tc: params[:cv_tc],
        fullcolor: params[:cv_fullcolor],
        fullcomp: params[:cv_fullcomp],
        tintcolor: params[:cv_tintcolor],
        tintcomp: params[:cv_tintcomp],
        tc_value: params[:cv_tc_value],
        temp: params[:cv_temp],
        time: params[:cv_time],
        thickness: params[:cv_thickness],
        testShape: params[:cv_testShape]
      )
      cd = Colordifference.new(
        formtype: mb_n.formtype,
        proto_id: @mb.id,
        number: @mb.number,
        measureDate: params[:cd_measureDate],
        fullL: params[:cd_fullL].to_f.floor(2),
        fulla: params[:cd_fulla].to_f.floor(2),
        fullb: params[:cd_fullb].to_f.floor(2),
        tintL: params[:cd_tintL].to_f.floor(2),
        tinta: params[:cd_tinta].to_f.floor(2),
        tintb: params[:cd_tintb].to_f.floor(2),
        fulldL: params[:cd_fulldL].to_f.floor(2),
        fullda: params[:cd_fullda].to_f.floor(2),
        fulldb: params[:cd_fulldb].to_f.floor(2),
        fulldE: params[:cd_fulldE].to_f.floor(2),
        tintdL: params[:cd_tintdL].to_f.floor(2),
        tintda: params[:cd_tintda].to_f.floor(2),
        tintdb: params[:cd_tintdb].to_f.floor(2),
        tintdE: params[:cd_tintdE].to_f.floor(2)
      )
      mv = Moisturevalue.new(
        formtype: mb_n.formtype,
        proto_id: @mb.id,
        number: @mb.number,
        measureDate: params[:mv_measureDate],
        temp: params[:mv_temp],
        time: params[:mv_time],
        endpoint: params[:mv_endpoint],
        MV: params[:mv_MV]
      )
      vrv = Vrvalue.new(
        formtype: mb_n.formtype,
        proto_id: @mb.id,
        number: @mb.number,
        measureDate: params[:vrv_measureDate],
        compname: params[:vrv_compname],
        temp: params[:vrv_temp],
        time: params[:vrv_time],
        color: params[:vrv_color],
        comp: params[:vrv_comp],
        thickness: params[:vrv_thickness],
        brank: params[:vrv_blank],
        brank_expo: params[:vrv_blank_expo],
        test: params[:vrv_test],
        test_expo: params[:vrv_test_expo],
        vr: params[:vrv_vr]
      )
      items = [cv , cd , mv , vrv]
      items.each do |item|
        if item.measureDate
          item.save
        end
      end
      redirect_to("/prototype/#{@mb.id}/show")
    else
      flash[:notice] = "情報の更新に失敗しました。"
      render("prototype/new_mb")
    end
  end

  def update_pc
    pc_n = PrototypeName.find_by(id: params[:id])
    pc = Prototype.new(
      formtype:pc_n.formtype,
      name:pc_n.id,
      client:pc_n.client,
      number:params[:number],
      measureDate:params[:measureDate],
      particle:params[:particle],
      conditions:params[:conditions],
      memo:params[:memo]
    )
    pc.save
    cv = Colorviewing.new(
      measureDate: params[:cv_measureDate],
      formtype: pc_n.formtype,
      proto_id: pc.id,
      number: pc.number,
      comp: params[:cv_comp],
      tc: params[:cv_tc],
      fullcolor: params[:cv_fullcolor],
      fullcomp: params[:cv_fullcomp],
      tintcolor: params[:cv_tintcolor],
      tintcomp: params[:cv_tintcomp],
      tc_value: params[:cv_tc_value],
      temp: params[:cv_temp],
      time: params[:cv_time],
      thickness: params[:cv_thickness],
      testShape: params[:cv_testShape]
    )
    cd = Colordifference.new(
      formtype: pc_n.formtype,
      proto_id: pc.id,
      number: pc.number,
      measureDate: params[:cd_measureDate],
      fullL: params[:cd_fullL].to_f.floor(2),
      fulla: params[:cd_fulla].to_f.floor(2),
      fullb: params[:cd_fullb].to_f.floor(2),
      tintL: params[:cd_tintL].to_f.floor(2),
      tinta: params[:cd_tinta].to_f.floor(2),
      tintb: params[:cd_tintb].to_f.floor(2),
      fulldL: params[:cd_fulldL].to_f.floor(2),
      fullda: params[:cd_fullda].to_f.floor(2),
      fulldb: params[:cd_fulldb].to_f.floor(2),
      fulldE: params[:cd_fulldE].to_f.floor(2),
      tintdL: params[:cd_tintdL].to_f.floor(2),
      tintda: params[:cd_tintda].to_f.floor(2),
      tintdb: params[:cd_tintdb].to_f.floor(2),
      tintdE: params[:cd_tintdE].to_f.floor(2)
    )
    v = Viscosity.new(
      formtype: pc_n.formtype,
      proto_id: pc.id,
      number: pc.number,
      measureDate: params[:v_measureDate],
      temp: params[:v_temp],
      roter: params[:v_roter],
      speed1: params[:v_speed1],
      speed2: params[:v_speed2],
      vs1: params[:v_vs1],
      vs2: params[:v_vs2],
    )
    mv = Moisturevalue.new(
      formtype: pc_n.formtype,
      proto_id: pc.id,
      number: pc.number,
      measureDate: params[:mv_measureDate],
      temp: params[:mv_temp],
      time: params[:mv_time],
      endpoint: params[:mv_endpoint],
      MV: params[:mv_MV]
    )

    items = [cv , cd , v , mv]
    items.each do |item|
      if item.measureDate
        item.save
      end
    end

    redirect_to("/prototype/#{pc.id}/show")
  end

  def show
    @proto = Prototype.find_by(id: params[:id])
    @name = PrototypeName.find_by(id: @proto.name)
    @client = Client.find_by(id: @proto.client)
    if @proto.formtype == "masterbatch"
      if cvs = Colorviewing.where(proto_id: @proto.id)
        @cvs = Colorviewing.where(proto_id: @proto.id)
      end
      if cds = Colordifference.where(proto_id: @proto.id)
        @cds = Colordifference.where(proto_id: @proto.id)
      end
      if mvs = Moisturevalue.where(proto_id: @proto.id)
        @mvs = Moisturevalue.where(proto_id: @proto.id)
      end
      if vrvs = Vrvalue.where(proto_id: @proto.id)
        @vrvs = Vrvalue.where(proto_id: @proto.id)
      end
    elsif @proto.formtype == "pastecolor"
      if cvs = Colorviewing.where(proto_id: @proto.id)
        @cvs = Colorviewing.where(proto_id: @proto.id)
      end
      if cds = Colordifference.where(proto_id: @proto.id)
        @cds = Colordifference.where(proto_id: @proto.id)
      end
      if v = Viscosity.where(proto_id: @proto.id)
        @vs = Viscosity.where(proto_id: @proto.id)
      end
      if mvs = Moisturevalue.where(proto_id: @proto.id)
        @mvs = Moisturevalue.where(proto_id: @proto.id)
      end
    end
  end

  def index
    @protos_name = PrototypeName.order(name: :asc)
    @protos = Prototype.order(name: :asc)
  end

  def sort
    if params[:column] == "name"
      if @proto_name = PrototypeName.find_by(name: params[:search_txt])
        @protos = Prototype.order(name: :asc)
        @selected = "name"
        @text = params[:search_txt]
      else
        flash[:notice] = "検索結果が見つかりませんでした。"
        redirect_to("/prototype/index")
      end
    elsif params[:column] == "client"
      if @client = Client.find_by(name: params[:search_txt])
        @protos_name = PrototypeName.where(client: @client.id)
        @protos = Prototype.order(name: :asc)
        @selected = "client"
        @text = params[:search_txt]
      else
        flash[:notice] = "検索結果が見つかりませんでした。"
        render("prototype/index")
      end
    else
      flash[:notice] = "検索結果が見つかりませんでした。"
      render("prototype/index")
    end
  end

  def sort_client
    @clients = Client.order(name: :asc)
    @protos_name = PrototypeName.order(name: :asc)
    @protos = Prototype.order(name: :asc)
  end

  def sort_createdDate
    @protos = Prototype.order(measureDate: :desc)
  end

  def define_left_menu
    if session[:left_menu] != "prototype"
      session[:left_menu] = "prototype"
    end
  end

  def destroy_datas
    proto = Prototype.find_by(id:params[:id])
    if proto.formtype == "masterbatch"
      items = [Colorviewing , Colordifference , Moisturevalue , Vrvalue]
      items.each do |item|
        if content = item.find_by(proto_id:params[:id])
          content.destroy
        end
      end
      proto.destroy
      redirect_to("/prototype/index")
    elsif proto.formtype == "pastecolor"
      items = [Colorviewing , Colordifference , Viscosity , Moisturevalue]
      items.each do |item|
        if content = item.find_by(proto_id:params[:id])
          content.destroy
        end
      end
      proto.destroy
      redirect_to("/prototype/index")
    end
  end

  def destroy_proto
    proto = PrototypeName.find_by(id:params[:id])
    proto_datas = Prototype.where(name:proto.id)
    if proto.formtype == "masterbatch"
      proto_datas.each do |proto_data|
        cvs = Colorviewing.where(proto_id:proto_data.id)
        cds = Colordifference.where(proto_id:proto_data.id)
        mvs = Moisturevalue.where(proto_id:proto_data.id)
        vrvs = Vrvalue.where(proto_id:proto_data.id)
        arrays = [cvs , cds , mvs , vrvs]
        arrays.each do |array|
          array.each do |item|
            item.destroy
          end
        end
        proto_data.destroy
      end
      proto.destroy
      redirect_to("/prototype/index")
    elsif proto.formtype == "pastecolor"
      proto_datas.each do |proto_data|
        cvs = Colorviewing.where(proto_id:proto_data.id)
        cds = Colordifference.where(proto_id:proto_data.id)
        mvs = Moisturevalue.where(proto_id:proto_data.id)
        vs = Viscosity.where(proto_id:proto_data.id)
        arrays = [cvs , cds , mvs , vs]
        arrays.each do |array|
          array.each do |item|
            item.destroy
          end
        end
        proto_data.destroy
      end
      proto.destroy
      redirect_to("/prototype/index")
    end
  end

  def edit_proto
    @proto = PrototypeName.find_by(id:params[:id])
    if @proto.formtype == "masterbatch"
      @masterbatch = true
    else
      @pastecolor = true
    end
    @client = Client.find_by(id:@proto.client)
  end

  def update_proto
    @proto = PrototypeName.find_by(id:params[:id])

    if @client = Client.find_by(name:params[:client])
      @proto.client = @client.id
      @proto.formtype = params[:formtype]
      @proto.name = params[:name]
      if @proto.save
        flash[:notice] = "試作品情報を更新しました。"
        redirect_to("/prototype/index")
      else
        flash[:notice] = "試作品情報更新に失敗しました。"
        render("prototype/edit_proto")
      end
    else
      @client = Client.new(
        name: params[:client]
      )
      @proto.client = @client.id
      @proto.formtype = params[:formtype]
      @proto.name = params[:name]
    end
  end

  def add_data
    @proto = Prototype.find_by(id: params[:id])
    @name = PrototypeName.find_by(id: @proto.name)
    @client = Client.find_by(id: @proto.client)
  end

  def add_data_update
    @proto = Prototype.find_by(id: params[:id])
    @proto = Prototype.find_by(id:params[:id])

    if @proto.formtype == "masterbatch"
      @proto.memo = params[:memo]
      @proto.save

      cv = Colorviewing.new(
        proto_id: @proto.id,
        measureDate: params[:cv_measureDate],
        comp: params[:cv_comp],
        tc: params[:cv_tc],
        fullcolor: params[:cv_fullcolor],
        fullcomp: params[:cv_fullcomp],
        tintcolor: params[:cv_tintcolor],
        tintcomp: params[:cv_tintcomp],
        tc_value: params[:cv_tc_value],
        temp: params[:cv_temp],
        time: params[:cv_time],
        thickness: params[:cv_thickness],
        testShape: params[:cv_testShape]
      )

      cd = Colordifference.new(
        proto_id: @proto.id,
        measureDate: params[:cd_measureDate],
        fullL: params[:cd_fullL],
        fulla: params[:cd_fulla],
        fullb: params[:cd_fullb],
        tintL: params[:cd_tintL],
        tinta: params[:cd_tinta],
        tintb: params[:cd_tintb],
        fulldL: params[:cd_fulldL],
        fullda: params[:cd_fullda],
        fulldb: params[:cd_fulldb],
        fulldE: params[:cd_fulldE],
        tintdL: params[:cd_tintdL],
        tintda: params[:cd_tintda],
        tintdb: params[:cd_tintdb],
        tintdE: params[:cd_tintdE]
      )

      mv = Moisturevalue.new(
        proto_id: @proto.id,
        measureDate: params[:mv_measureDate],
        temp: params[:mv_temp],
        time: params[:mv_time],
        endpoint: params[:mv_endpoint],
        MV: params[:mv_MV]
      )

      vrv = Vrvalue.new(
        proto_id:params[:id],
        measureDate: params[:vrv_measureDate],
        compname: params[:vrv_compname],
        temp: params[:vrv_temp],
        time: params[:vrv_time],
        color: params[:vrv_color],
        comp: params[:vrv_comp],
        thickness: params[:vrv_thickness],
        brank: params[:vrv_brank],
        brank_expo: params[:vrv_brank_expo],
        test: params[:vrv_test],
        test_expo: params[:vrv_test_expo],
        vr: params[:vrv_vr]
      )

      items = [cv , cd , mv , vrv]
      items.each do |item|
        if item.measureDate
          item.save
        end
      end
      flash[:notice] = "試作品情報を追加しました。"
      redirect_to("/prototype/#{params[:id]}/show")

    elsif @proto.formtype == "pastecolor"
      @proto = Prototype.find_by(id:params[:id])
      @proto.memo = params[:memo]
      @proto.save

      cv = Colorviewing.new(
        proto_id: @proto.id,
        measureDate: params[:cv_measureDate],
        comp: params[:cv_comp],
        tc: params[:cv_tc],
        fullcolor: params[:cv_fullcolor],
        fullcomp: params[:cv_fullcomp],
        tintcolor: params[:cv_tintcolor],
        tintcomp: params[:cv_tintcomp],
        tc_value: params[:cv_tc_value],
        temp: params[:cv_temp],
        time: params[:cv_time],
        thickness: params[:cv_thickness],
        testShape: params[:cv_testShape]
      )

      cd = Colordifference.new(
        proto_id: @proto.id,
        measureDate: params[:cd_measureDate],
        fullL: params[:cd_fullL],
        fulla: params[:cd_fulla],
        fullb: params[:cd_fullb],
        tintL: params[:cd_tintL],
        tinta: params[:cd_tinta],
        tintb: params[:cd_tintb],
        fulldL: params[:cd_fulldL],
        fullda: params[:cd_fullda],
        fulldb: params[:cd_fulldb],
        fulldE: params[:cd_fulldE],
        tintdL: params[:cd_tintdL],
        tintda: params[:cd_tintda],
        tintdb: params[:cd_tintdb],
        tintdE: params[:cd_tintdE]
      )

      v = Viscosity.new(
        proto_id: @proto.id,
        measureDate: params[:v_measureDate],
        temp: params[:v_temp],
        roter: params[:v_roter],
        speed1: params[:v_speed1],
        speed2: params[:v_speed2],
        vs1: params[:v_vs1],
        vs2: params[:v_vs2]
      )

      mv = Moisturevalue.new(
        proto_id: @proto.id,
        measureDate: params[:mv_measureDate],
        temp: params[:mv_temp],
        time: params[:mv_time],
        endpoint: params[:mv_endpoint],
        MV: params[:mv_MV]
      )

      items = [cv , cd , v , mv]
      items.each do |item|
        if item.measureDate
          item.save
        end
      end
      flash[:notice] = "試作品情報を追加しました。"
      redirect_to("/prototype/#{params[:id]}/show")
    end
  end

  def data
    case params[:table]
    when "cv"
      @data = Colorviewing.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "cd"
      @data = Colordifference.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "mv"
      @data = Moisturevalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "vrv"
      @data = Vrvalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "v"
      @data = Viscosity.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    end
  end

  def edit_data
    case params[:table]
    when "proto"
      @proto = Prototype.find_by(id: params[:id])
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "cv"
      @data = Colorviewing.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "cd"
      @data = Colordifference.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "mv"
      @data = Moisturevalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "vrv"
      @data = Vrvalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    when "v"
      @data = Viscosity.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)
    end
  end

  def update_data
    case params[:table]
    when "proto"
      @data = Prototype.find_by(id: params[:id])
      @name = PrototypeName.find_by(id: @data.name)
      @client = Client.find_by(id: @name.client)

      @data.number = params[:number]
      @data.measureDate = params[:measureDate]
      @data.particle = params[:particle]
      @data.conditions = params[:conditions]
      @data.memo = params[:memo]
    when "cv"
      @data = Colorviewing.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)

      @data.measureDate = params[:cv_measureDate]
      @data.comp = params[:cv_comp]
      @data.tc = params[:cv_tc]
      @data.fullcolor = params[:cv_fullcolor]
      @data.fullcomp = params[:cv_fullcomp]
      @data.tintcolor = params[:cv_tintcolor]
      @data.tintcomp = params[:cv_tintcomp]
      @data.tc_value = params[:cv_tc_value]
      @data.temp = params[:cv_temp]
      @data.time = params[:cv_time]
      @data.thickness = params[:cv_thickness]
      @data.testShape = params[:cv_testShape]
    when "cd"
      @data = Colordifference.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)

      @data.measureDate = params[:cd_measureDate]
      @data.fullL = params[:cd_fullL].to_f.floor(2)
      @data.fulla = params[:cd_fulla].to_f.floor(2)
      @data.fullb = params[:cd_fullb].to_f.floor(2)
      @data.tintL = params[:cd_tintL].to_f.floor(2)
      @data.tinta = params[:cd_tinta].to_f.floor(2)
      @data.tintb = params[:cd_tintb].to_f.floor(2)
      @data.fulldL = params[:cd_fulldL].to_f.floor(2)
      @data.fullda = params[:cd_fullda].to_f.floor(2)
      @data.fulldb = params[:cd_fulldb].to_f.floor(2)
      @data.fulldE = params[:cd_fulldE].to_f.floor(2)
      @data.tintdL = params[:cd_tintdL].to_f.floor(2)
      @data.tintda = params[:cd_tintda].to_f.floor(2)
      @data.tintdb = params[:cd_tintdb].to_f.floor(2)
      @data.tintdE = params[:cd_tintdE].to_f.floor(2)
    when "mv"
      @data = Moisturevalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)

      @data.measureDate = params[:mv_measureDate]
      @data.temp = params[:mv_temp]
      @data.time = params[:mv_time]
      @data.endpoint = params[:mv_endpoint]
      @data.MV = params[:mv_MV]
    when "vrv"
      @data = Vrvalue.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)

      @data.measureDate = params[:vrv_measureDate]
      @data.compname = params[:vrv_compname]
      @data.temp = params[:vrv_temp]
      @data.time = params[:vrv_time]
      @data.color = params[:vrv_color]
      @data.comp = params[:vrv_comp]
      @data.thickness = params[:vrv_thickness]
      @data.brank = params[:vrv_brank]
      @data.brank_expo = params[:vrv_brank_expo]
      @data.test = params[:vrv_test]
      @data.test_expo = params[:vrv_test_expo]
      @data.vr = params[:vrv_vr]
    when "v"
      @data = Viscosity.find_by(id: params[:id])
      @proto = Prototype.find_by(id: @data.proto_id)
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @name.client)

      @data.measureDate = params[:v_measureDate]
      @data.temp = params[:v_temp]
      @data.roter = params[:v_roter]
      @data.speed1 = params[:v_speed1]
      @data.speed2 = params[:v_speed2]
      @data.vs1 = params[:v_vs1]
      @data.vs2 = params[:v_vs2]
    end

    if @data.save
      flash[:notice] = "試作品情報を更新しました。"
      redirect_to("/prototype/#{@proto.id}/show")
    else
      flash[:notice] = "試作品情報の編集に失敗しました。"
      render("prototype/edit_data")
    end
  end

  def destroy_data
    case params[:table]
    when "cv"
      data = Colorviewing.find_by(id: params[:id])
      proto = Prototype.find_by(id: data.proto_id)
      if data.destroy
        flash[:notice] = "試作品情報を削除しました。"
        redirect_to("/prototype/#{proto.id}/show")
      else
        flash[:notice] = "試作品情報の削除に失敗しました。"
        redirect_to("/prototype/#{proto.id}/show")
      end
    when "cd"
      data = Colordifference.find_by(id: params[:id])
      proto = Prototype.find_by(id: data.proto_id)
      if data.destroy
        flash[:notice] = "試作品情報を削除しました。"
        redirect_to("/prototype/#{proto.id}/show")
      else
        flash[:notice] = "試作品情報の削除に失敗しました。"
        redirect_to("/prototype/#{proto.id}/show")
      end
    when "mv"
      data = Moisturevalue.find_by(id: params[:id])
      proto = Prototype.find_by(id: data.proto_id)
      if data.destroy
        flash[:notice] = "試作品情報を削除しました。"
        redirect_to("/prototype/#{proto.id}/show")
      else
        flash[:notice] = "試作品情報の削除に失敗しました。"
        redirect_to("/prototype/#{proto.id}/show")
      end
    when "vrv"
      data = Vrvalue.find_by(id: params[:id])
      proto = Prototype.find_by(id: data.proto_id)
      if data.destroy
        flash[:notice] = "試作品情報を削除しました。"
        redirect_to("/prototype/#{proto.id}/show")
      else
        flash[:notice] = "試作品情報の削除に失敗しました。"
        redirect_to("/prototype/#{proto.id}/show")
      end
    when "v"
      data = Viscosity.find_by(id: params[:id])
      proto = Prototype.find_by(id: data.proto_id)
      if data.destroy
        flash[:notice] = "試作品情報を削除しました。"
        redirect_to("/prototype/#{proto.id}/show")
      else
        flash[:notice] = "試作品情報の削除に失敗しました。"
        redirect_to("/prototype/#{proto.id}/show")
      end
    end
  end

  def report
    @protos_name = PrototypeName.order(name: :asc)
    @protos = Prototype.order(name: :asc)
  end

  def write_report
    if params[:data]
      @proto = Prototype.find_by(id: params[:data])
      @name = PrototypeName.find_by(id: @proto.name)
      @client = Client.find_by(id: @proto.client)
      if cvs = Colorviewing.where(proto_id: @proto.id)
        @cvs = Colorviewing.where(proto_id: @proto.id).order(measureDate: :asc)
      end
      if cds = Colordifference.where(proto_id: @proto.id)
        @cds = Colordifference.where(proto_id: @proto.id).order(measureDate: :asc)
      end
      if mvs = Moisturevalue.where(proto_id: @proto.id)
        @mvs = Moisturevalue.where(proto_id: @proto.id).order(measureDate: :asc)
      end
      if @proto.formtype == "masterbatch"
        if vrvs = Vrvalue.where(proto_id: @proto.id)
          @vrvs = Vrvalue.where(proto_id: @proto.id).order(measureDate: :asc)
        end
      elsif @proto.formtype == "pastecolor"
        if vs = Viscosity.where(proto_id: @proto.id)
          @vs = Viscosity.where(proto_id: @proto.id).order(measureDate: :asc)
        end
      end
      respond_to do |format|
        format.html
        format.xlsx do
          response.headers['Content-Disposition'] = "attachment; filename=#{@name.name}_#{@proto.number}.xlsx"
        end
      end
    else
      flash[:notice] = "試作品を選択してください。"
      render("prototype/report")
    end
  end

end
