class HGVTransIdentifier < HGVIdentifier
  PATH_PREFIX = 'HGV_trans_EpiDoc'
  
  def to_path
    if alternate_name.nil?
      # no alternate name, use SoSOL temporary path
      return self.temporary_path
    else
      path_components = [ PATH_PREFIX ]
      # assume the alternate name is e.g. hgv2302zzr
      trimmed_name = alternate_name.sub(/^hgv/, '') # 2302zzr

      hgv_xml_path = trimmed_name + '.xml'

      # HGV_trans_EpiDoc uses a flat hierarchy
      path_components << hgv_xml_path

      # e.g. HGV_trans_EpiDoc/2302zzr.xml
      return File.join(path_components)
    end
  end
  
  def id_attribute
    return "hgv-TEMP"
  end
  
  def n_attribute
    ddb = DDBIdentifier.find_by_publication_id(self.publication.id, :limit => 1)
    return ddb.n_attribute
  end
  
  def xml_title_text
    return " HGVTITLE (DDBTITLE) "
  end
end